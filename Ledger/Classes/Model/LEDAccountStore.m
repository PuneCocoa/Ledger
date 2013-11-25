//
//  LEDAccountStore.m
//  Ledger
//
//  Created by Harshad on 25/11/2013.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDAccountStore.h"

@interface LEDAccountStore ()

@property (strong, nonatomic) NSMutableArray *persistentAccounts;

@end

@implementation LEDAccountStore

#pragma mark - Public methods

- (NSMutableArray *)persistentAccounts {
    
    if (_persistentAccounts == nil) {
        _persistentAccounts = [NSMutableArray new];
    }
    
    return _persistentAccounts;
}

- (NSArray *)accounts {
    
    return self.persistentAccounts;
}


- (void)addAccount:(LEDAccount *)anAccount {
    
    if (![self.persistentAccounts containsObject:anAccount]) {
        
        [self.persistentAccounts addObject:anAccount];
        
    }
}

- (void)deleteAccount:(LEDAccount *)anAccount {
    
    [self.persistentAccounts removeObject:anAccount];
}

- (void)save {
    // TODO: save accounts
}

- (void)deleteAllAccounts {
    
    [self.persistentAccounts removeAllObjects];
}


@end
