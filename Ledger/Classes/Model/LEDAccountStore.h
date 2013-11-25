//
//  LEDAccountStore.h
//  Ledger
//
//  Created by Harshad Dange on 25/11/2013.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LEDAccount;

@interface LEDAccountStore : NSObject

- (NSArray *)accounts;

- (void)addAccount:(LEDAccount *)anAccount;
- (void)deleteAccount:(LEDAccount *)anAccount;

- (void)save;
- (void)deleteAllAccounts;

@end
