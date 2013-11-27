//
//  LEDTransaction.h
//  Ledger
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LEDAccount;

@interface LEDTransaction : NSObject

+ (instancetype)transactionWithAmount:(double)amount detail:(NSString *)detail date:(NSDate *)date;

- (double)amount;
- (NSString *)detail;
- (NSDate *)date;


@end
