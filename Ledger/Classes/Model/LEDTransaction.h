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

+ (instancetype)transactionWithAmount:(float)amount detail:(NSString *)detail;

- (float)amount;
- (NSString *)detail;


@end
