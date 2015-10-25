//
//  HLLDetailViewModel.h
//  HLLContactsDemo
//
//  Created by apple on 15/10/25.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLPhone : NSObject

@property (nonatomic ,strong) NSString * phoneNumber;
@property (nonatomic ,strong) NSString * phoneLabel;
@end

@interface HLLDetailViewModel : NSObject

@property (nonatomic ,strong) NSData    * imageData;
@property (nonatomic ,strong) NSString  * name;
// all CNLabeledValue obj
@property (nonatomic ,strong) NSArray   * phoneNumbers;
// all HLLPhone obj
- (NSArray *) phonesWithPhoneNumbers:(NSArray *)phoneNumbers;
@end
