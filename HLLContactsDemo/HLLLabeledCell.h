//
//  HLLLabeledCell.h
//  HLLContactsDemo
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 HLL. All rights reserved.
//

#define kCellIdentifier_Label @"HLLLabeledCell"
#import <UIKit/UIKit.h>
#import "HLLDetailViewModel.h"

@interface HLLLabeledCell : UITableViewCell

- (void) configureCellWithLabeledVaule:(HLLPhone *)phone;

@end
