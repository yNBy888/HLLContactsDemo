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
    
    NSString * start = @"_$!<";
    NSString * end = @">!$_";
    
    NSString * predicateString = [NSString stringWithFormat:@"self beginswith '%@' and self endswith '%@'",start,end];
    NSPredicate * labelPredicate = [NSPredicate predicateWithFormat:predicateString];
    
    NSMutableString * newLabel = [NSMutableString stringWithString:label];
    
    if ([labelPredicate evaluateWithObject:label]) {
        NSLog(@"yes ,its");
        NSRange startRange = [newLabel rangeOfString:start];
        [newLabel deleteCharactersInRange:startRange];
        NSRange endRange = [newLabel rangeOfString:end];
        [newLabel deleteCharactersInRange:endRange];
        
    }else{
        NSLog(@"no ,itnot");
    }
    self.labelLabel.text = newLabel;

    self.phoneNumberLabel.text = phoneNumber.stringValue;
}
@end
