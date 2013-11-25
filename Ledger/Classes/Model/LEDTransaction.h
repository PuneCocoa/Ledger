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

+ (instancetype)transactionWithAccount:(LEDAccount *)account amount:(float)amount detail:(NSString *)detail;

- (LEDAccount *)account;
- (float)amount;
- (NSString *)detail;


@end
