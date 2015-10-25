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

#import "HLLContactViewModel.h"

static NSString * const identifier = @"contactIdentifier";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,CNContactPickerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ODRefreshControl *myRefreshControl;
@property (nonatomic ,strong) NSArray * contacts;

@property (nonatomic ,strong) HLLContactViewModel * viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    _myRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [_myRefreshControl addTarget:self action:@selector(fetchContactInfo) forControlEvents:UIControlEventValueChanged];
    
    _viewModel = [[HLLContactViewModel alloc] init];
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
        self.contacts = [self.viewModel pullContacts];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [_myRefreshControl endRefreshing];
        });
    });
}

#pragma mark - segue action
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier  isEqualToString: @"detail"]) {
        HLLDetailViewController * destinationViewController = segue.destinationViewController;
        NSIndexPath * selectedIndexPath = self.tableView.indexPathForSelectedRow;
        if (selectedIndexPath) {
            
            NSArray * contactArray = [self.contacts objectAtIndex:selectedIndexPath.row];
            CNContact * contact = [contactArray objectAtIndex:0];
            destinationViewController.viewModel = [self.viewModel fetchDetailViewModelWithContact:contact];
            destinationViewController.title = @"联系人详情";
        }
    }
}
#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"⚠️" message:@"Choice Your Choice!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * systemAction = [UIAlertAction actionWithTitle:@"System" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self viewControllerGotoSystemContactUIWithIndexPath:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    [self viewControllerGotoCustomContactUI];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIAlertAction * customAction = [UIAlertAction actionWithTitle:@"Custom" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:systemAction];
    [alertController addAction:customAction];
//    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    
}

- (void) viewControllerGotoSystemContactUIWithIndexPath:(NSIndexPath *)indexPath{

    NSArray * contactArray = [self.contacts objectAtIndex:indexPath.row];
    CNContact * contact = [contactArray objectAtIndex:0];
    CNMutableContact * mutableContact = [[CNMutableContact alloc] init];
    mutableContact.contactType = CNContactTypePerson;
    mutableContact.givenName = contact.givenName;
    mutableContact.familyName = contact.familyName;
    mutableContact.phoneNumbers = contact.phoneNumbers;
    mutableContact.emailAddresses = contact.emailAddresses;
    
    CNContactViewController * contactViewController = [CNContactViewController viewControllerForContact:mutableContact];
    contactViewController.title = @"联系人详情";
    contactViewController.allowsEditing = NO;
    [self.navigationController pushViewController:contactViewController animated:YES];
}
- (void) viewControllerGotoCustomContactUI{
    [self performSegueWithIdentifier:@"detail" sender:nil];
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
