//
//  LEDAccount.m
//  Ledger
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDAccount.h"

@implementation LEDAccount

#pragma mark - Initialisation

+ (instancetype)accountWithName:(NSString *)name {

    LEDAccount *anAccount = [LEDAccount new];
    [anAccount setName:name];

    return anAccount;
}

#pragma mark - Public methods

- (float)balance {
    return 0.0f;
}

- (float)totalDeposits {
    return 0.0f;
}

- (float)totalWithdrawals {
    return 0.0f;
}

- (NSArray *)transactions {
    return nil;
}



@end
