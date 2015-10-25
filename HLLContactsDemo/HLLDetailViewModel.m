//
//  HLLDetailViewModel.m
//  HLLContactsDemo
//
//  Created by apple on 15/10/25.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLDetailViewModel.h"
#import <Contacts/Contacts.h>

@implementation HLLPhone

@end

@implementation HLLDetailViewModel

- (NSArray *)phones{

    return [self phonesWithPhoneNumbers:self.phoneNumbers];
}

- (NSArray *)phonesWithPhoneNumbers:(NSArray *)phoneNumbers{

    NSMutableArray * phones = [NSMutableArray array];
    
    [phoneNumbers enumerateObjectsUsingBlock:^(CNLabeledValue * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HLLPhone * phone = [[HLLPhone alloc] init];
        phone.phoneLabel = [self phoneLabelWithLabeledValue:obj];
        phone.phoneNumber = [self phoneNumberWithLabelValue:obj];
        [phones addObject:phone];
    }];
    return phones;
}

- (NSString *) phoneLabelWithLabeledValue:(CNLabeledValue *)labelValue{

    NSString * label = labelValue.label;
    
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
    }
    return newLabel;
}
- (NSString *) phoneNumberWithLabelValue:(CNLabeledValue *)labelValue{

    CNPhoneNumber * phoneNumber = labelValue.value;

    NSMutableString * newStringValue = [NSMutableString stringWithString:phoneNumber.stringValue];
    
    return newStringValue;
}

@end
