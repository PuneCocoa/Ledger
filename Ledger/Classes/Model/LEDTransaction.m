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

    float _amount;
    NSString *_detail;
}

+ (instancetype)transactionWithAmount:(float)amount detail:(NSString *)detail {

    LEDTransaction *transaction = [[self class] new];

    transaction->_amount = amount;
    transaction->_detail = [detail copy];

    return transaction;
}


- (float)amount {
    
    return _amount;
    
}

- (NSString *)detail {

    return _detail;
}

@end
