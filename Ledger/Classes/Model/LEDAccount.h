//
//  LEDAccount.h
//  Ledger
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LEDTransaction;

@interface LEDAccount : NSObject

+ (instancetype)accountWithName:(NSString *)name;

- (float)balance;
- (float)totalDeposits;
- (float)totalWithdrawals;

- (NSArray *)transactions;
- (void)addTransaction:(LEDTransaction *)aTransaction;
- (void)deleteTransaction:(LEDTransaction *)aTransaction;
- (void)deleteAllTransactions;

@property (copy, nonatomic) NSString *name;


@end
