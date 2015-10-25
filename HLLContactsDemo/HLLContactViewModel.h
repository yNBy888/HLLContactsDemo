//
//  HLLContactViewModel.h
//  HLLContactsDemo
//
//  Created by apple on 15/10/25.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>

@class HLLDetailViewModel;
@interface HLLContactViewModel : NSObject


- (NSArray *) pullContacts;
- (HLLDetailViewModel *) fetchDetailViewModelWithContact:(CNContact *)contact;

@end
