//
//  LEDAccount.m
//  Ledger
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDAccount.h"

#import "LEDTransaction.h"

@implementation LEDAccount {
    
    NSMutableArray *_transactions;
}

#pragma mark - Initialisation

+ (instancetype)accountWithName:(NSString *)name {

    LEDAccount *anAccount = [LEDAccount new];
    [anAccount setName:name];

    return anAccount;
}

#pragma mark - Public methods

- (double)balance {
    
    return [self totalDeposits] - [self totalWithdrawals];
}

- (double)totalDeposits {
    
    double totalDeposits = 0.0f;
    
    for (LEDTransaction *aTransaction in self.transactions) {
        if (aTransaction.amount > 0) {
            totalDeposits += aTransaction.amount;
        }
    }
    
    return totalDeposits;
}

- (double)totalWithdrawals {
    
    double totalWithdrawals = 0.0f;
    
    for (LEDTransaction *aTransaction in self.transactions) {
        
        if (aTransaction.amount < 0) {
            
            totalWithdrawals += aTransaction.amount;
        }
    }
    
    return -totalWithdrawals;
}

- (NSArray *)transactions {

    NSSortDescriptor *sortDescendingByDate = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [_transactions sortUsingDescriptors:@[sortDescendingByDate]];

    return _transactions;
}

- (void)addTransaction:(LEDTransaction *)aTransaction {
    
    if (_transactions == nil) {
        
        _transactions = [NSMutableArray new];
    }
    
    [_transactions addObject:aTransaction];
    
}

- (void)deleteTransaction:(LEDTransaction *)aTransaction {
    
    [_transactions removeObject:aTransaction];
}

- (void)deleteAllTransactions {
    
    [_transactions removeAllObjects];
}



@end
