//
//  HLLDetailViewController.m
//  HLLContactsDemo
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLDetailViewController.h"
#import "HLLLabeledCell.h"

@interface HLLDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *phoneTableView;
@property (nonatomic ,strong) NSArray * phoneNumbers;
@property (nonatomic ,strong) NSArray * emailAddresses;
@end

@implementation HLLDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.phoneTableView registerClass:[HLLLabeledCell class] forCellReuseIdentifier:kCellIdentifier_Label];
    if (self.contact.imageData) {
        self.iconImageView.image = [UIImage imageWithData:self.contact.imageData];
    }
    NSString * nickName = self.contact.nickname;
    NSString * giveName = self.contact.givenName;
    NSString * familyName = self.contact.familyName;
    NSString * organizationName = self.contact.organizationName;
    
    if (nickName.length) {
        self.nameLabel.text = nickName;
    }else{
        if (familyName.length) {
            self.nameLabel.text = [NSString stringWithFormat:@"%@%@",familyName,giveName];
        }else if(giveName.length){
            self.nameLabel.text = [NSString stringWithFormat:@"%@",giveName];
        }else{
            self.nameLabel.text = [NSString stringWithFormat:@"%@",organizationName];
        }
    }

    self.phoneNumbers = self.contact.phoneNumbers;
    self.emailAddresses = self.contact.emailAddresses;
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern.png"]];
    [self.phoneTableView reloadData];
}
#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CNLabeledValue * labeledValue = [self.phoneNumbers objectAtIndex:indexPath.row];

    CNPhoneNumber * phoneNumber = labeledValue.value;
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat: @"telprompt://%@",phoneNumber.stringValue]];
    
    [[UIApplication sharedApplication] openURL:url];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60.0;
}
#pragma mark - UITableViewDatasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.phoneNumbers.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HLLLabeledCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Label forIndexPath:indexPath];
    CNLabeledValue * labeledValue = [self.phoneNumbers objectAtIndex:indexPath.row];
    [cell configureCellWithLabeledVaule:labeledValue];
    return cell;
}
@end
