//
//  HLLDetailViewController.m
//  HLLContactsDemo
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLDetailViewController.h"
#import "HLLLabeledCell.h"
#import "HLLDetailViewModel.h"


@interface HLLDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *phoneTableView;
@property (nonatomic ,strong) NSArray * phones;

@end

@implementation HLLDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.viewModel.imageData) {
        self.iconImageView.image = [UIImage imageWithData:self.viewModel.imageData];
    }
    self.nameLabel.text = self.viewModel.name;
    
    self.phones = [self.viewModel phonesWithPhoneNumbers:self.viewModel.phoneNumbers];

    [self.phoneTableView reloadData];
}
#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HLLPhone * phone = [self.phones objectAtIndex:indexPath.row];
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat: @"telprompt://%@",phone.phoneNumber]];
    
    [[UIApplication sharedApplication] openURL:url];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60.0;
}
#pragma mark - UITableViewDatasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.phones.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HLLLabeledCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Label forIndexPath:indexPath];

    HLLPhone * phone = [self.phones objectAtIndex:indexPath.row];
    
    [cell configureCellWithPhone:phone];
    
    return cell;
}
@end
