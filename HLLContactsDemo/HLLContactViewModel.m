//
//  HLLContactViewModel.m
//  HLLContactsDemo
//
//  Created by apple on 15/10/25.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLContactViewModel.h"
#import "HLLDetailViewModel.h"

@implementation HLLContactViewModel

- (NSArray *)pullContacts{
    
    CNContactStore * store = [[CNContactStore alloc] init];
    
    NSMutableArray * contacts = [NSMutableArray array];
    
    NSArray * fetch = @[CNContactNicknameKey,
                        CNContactImageDataKey,
                        CNContactGivenNameKey,
                        CNContactFamilyNameKey,
                        CNContactPhoneNumbersKey,
                        CNContactOrganizationNameKey,
                        CNContactEmailAddressesKey,
                        CNContactDatesKey];
    CNContactFetchRequest * fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetch];
    
    @try {
        [store enumerateContactsWithFetchRequest:fetchRequest error:NULL usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            [contacts addObject:@[contact]];
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"exception:%@",exception.name);
    }
    @finally {
        
    }
    return contacts;
}

- (HLLDetailViewModel *) fetchDetailViewModelWithContact:(CNContact *)contact{

    HLLDetailViewModel * detailViewModel = [[HLLDetailViewModel alloc] init];
    detailViewModel.name = [self nameWithContact:contact];
    detailViewModel.imageData = [self imageDataWithContact:contact];
    detailViewModel.phoneNumbers = [self phoneNumbersWithContact:contact];
    return detailViewModel;
}

- (NSString *) nameWithContact:(CNContact *)contact{

    NSString * nickName = contact.nickname;
    NSString * giveName = contact.givenName;
    NSString * familyName = contact.familyName;
    NSString * organizationName = contact.organizationName;
    
    NSString * name = @"";
    if (nickName.length) {
        name = nickName;
    }else{
        if (familyName.length) {
            name = [NSString stringWithFormat:@"%@%@",familyName,giveName];
        }else if(giveName.length){
            name = [NSString stringWithFormat:@"%@",giveName];
        }else{
            name = [NSString stringWithFormat:@"%@",organizationName];
        }
    }
    return name;
}
- (NSData *) imageDataWithContact:(CNContact *)contact{

    return contact.imageData;;
}
- (NSArray *) phoneNumbersWithContact:(CNContact *)contact{

    return contact.phoneNumbers;
}
@end
