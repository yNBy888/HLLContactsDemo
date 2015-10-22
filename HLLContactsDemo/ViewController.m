//
//  ViewController.m
//  HLLContactsDemo
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "ViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "HLLDetailViewController.h"
#import "ODRefreshControl.h"

static NSString * const identifier = @"contactIdentifier";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,CNContactPickerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ODRefreshControl *myRefreshControl;
@property (nonatomic ,strong) NSArray * contacts;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    _myRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [_myRefreshControl addTarget:self action:@selector(fetchContactInfo) forControlEvents:UIControlEventValueChanged];
}
- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self fetchContactInfo];
}
- (IBAction)showContactPicker:(id)sender {
    CNContactPickerViewController * contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
    [self.navigationController presentViewController:contactPicker animated:YES completion:nil];

}

- (void) fetchContactInfo{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (self.contacts) {
            self.contacts = nil;
        }
        self.contacts = [self _contacts];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [_myRefreshControl endRefreshing];
        });
    });

}
- (NSArray *) _contacts{
    
    CNContactStore * store = [[CNContactStore alloc] init];
    
    NSMutableArray * contacts = [NSMutableArray array];
    
    NSArray * fetch = @[CNContactNicknameKey,
                        CNContactImageDataKey,
                        CNContactGivenNameKey,
                        CNContactFamilyNameKey,
                        CNContactPhoneNumbersKey,
                        CNContactOrganizationNameKey,
                        CNContactEmailAddressesKey,
                        CNContactDatesKey];
    CNContactFetchRequest * fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetch];
    
    @try {
        [store enumerateContactsWithFetchRequest:fetchRequest error:NULL usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            [contacts addObject:@[contact]];
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"exception:%@",exception.name);
    }
    @finally {
        
    }
    
    return contacts;

}
#pragma mark - segue action
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier  isEqualToString: @"detail"]) {
        HLLDetailViewController * destinationViewController = segue.destinationViewController;
        NSIndexPath * selectedIndexPath = self.tableView.indexPathForSelectedRow;
        if (selectedIndexPath) {
            
            NSArray * contactArray = [self.contacts objectAtIndex:selectedIndexPath.row];
            CNContact * contact = [contactArray objectAtIndex:0];
            destinationViewController.contact = contact;
            destinationViewController.title = @"联系人详情";
        }
    }
}
#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self performSegueWithIdentifier:@"detail" sender:nil];
//    NSArray * contactArray = [self.contacts objectAtIndex:indexPath.row];
//    CNContact * contact = [contactArray objectAtIndex:0];
//    id obj = [CNContactViewController descriptorForRequiredKeys];
//    CNContactViewController * contactViewController = [CNContactViewController viewControllerForContact:contact];
//    
//    NSArray * fetch = @[CNContactNicknameKey,
//                        CNContactImageDataKey,
//                        CNContactGivenNameKey,
//                        CNContactFamilyNameKey,
//                        CNContactPhoneNumbersKey,
//                        CNContactOrganizationNameKey,
//                        CNContactEmailAddressesKey,
//                        CNContactDatesKey];
//    CNContactFetchRequest * fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetch];
//    NSLog(@"obj:%@",obj);
//    [self.navigationController presentViewController:contactViewController animated:YES completion:nil];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.contacts.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSArray * contactArray = self.contacts[indexPath.row];
    CNContact * contact = contactArray[0];
    
    NSString * giveName = contact.givenName;
    NSString * familyName = contact.familyName;
    NSString * organizationName = contact.organizationName;
    
    if (familyName.length) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@",familyName,giveName];
    }else if(giveName.length){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",giveName];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@",organizationName];
    }
    
    return cell;
}

#pragma mark - CNContactPickerDelegate

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{

}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{

}
@end
