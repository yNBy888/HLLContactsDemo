//
//  HLLDetailViewController.h
//  HLLContactsDemo
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>

@class HLLDetailViewModel;
@interface HLLDetailViewController : UIViewController
@property (nonatomic ,strong) HLLDetailViewModel * viewModel;
@property (nonatomic ,strong) CNContact * contact;
@end
