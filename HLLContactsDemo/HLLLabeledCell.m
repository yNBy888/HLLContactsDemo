//
//  HLLLabeledCell.m
//  HLLContactsDemo
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLLabeledCell.h"
#import <Contacts/Contacts.h>

@interface HLLLabeledCell ()
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end
@implementation HLLLabeledCell

- (void)configureCellWithLabeledVaule:(id)labeledVaule{

    CNLabeledValue * labelVaule = (CNLabeledValue *)labeledVaule;
    CNPhoneNumber * phoneNumber = labelVaule.value;
    NSString * label = labelVaule.label;
    NSRange startRange = [label rangeOfString:@"_$!<"];
    BOOL hasStart = [label hasPrefix:@"_$!<"];
    BOOL hasEnd = [label hasSuffix:@">!$_"];
    if (!hasEnd || !hasStart) {
        self.labelLabel.text = label;
    }else{
        NSString * tempString = [label substringFromIndex:startRange.length];
        NSRange endRange = [tempString rangeOfString:@">!$_"];
        tempString = [tempString substringToIndex:endRange.location];
        self.labelLabel.text = tempString ? : @" ";
    }
    self.phoneNumberLabel.text = phoneNumber.stringValue;
}
@end
