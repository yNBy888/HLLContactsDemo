//
//  HLLLabeledCell.m
//  HLLContactsDemo
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLLabeledCell.h"


@interface HLLLabeledCell ()
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end
@implementation HLLLabeledCell

- (void)configureCellWithPhone:(HLLPhone *)phone{

    self.labelLabel.text = phone.phoneLabel;
    self.phoneNumberLabel.text = phone.phoneNumber;
}
@end
