//
//  LEDTransaction.m
//  Ledger
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDTransaction.h"
#import "LEDAccount.h"

@implementation LEDTransaction {

    LEDAccount *_account;
    float _amount;
    NSString *_detail;
}

+ (instancetype)transactionWithAccount:(LEDAccount *)account amount:(float)amount detail:(NSString *)detail {

    LEDTransaction *transaction = [[self class] new];

    transaction->_account = account;
    transaction->_amount = amount;
    transaction->_detail = [detail copy];

    return transaction;
}

- (LEDAccount *)account {
    return _account;
}

- (float)amount {
    return _amount;
}

- (NSString *)detail {

    return _detail;
}

@end
