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

    double _amount;
    NSString *_detail;
    NSDate *_date;
}

+ (instancetype)transactionWithAmount:(double)amount detail:(NSString *)detail date:(NSDate *)date {

    LEDTransaction *transaction = [[self class] new];

    transaction->_amount = amount;
    transaction->_detail = [detail copy];
    transaction->_date = date;
    
    return transaction;
}


- (double)amount {
    
    return _amount;
    
}

- (NSString *)detail {

    return _detail;
}

- (NSDate *)date {
    
    return _date;
}


@end
