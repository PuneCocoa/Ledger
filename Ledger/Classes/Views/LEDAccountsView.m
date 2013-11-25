//
//  LEDAccountsView.m
//  Ledger
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDAccountsView.h"

@implementation LEDAccountsView {
    __weak UITableView *_accountsTableView;
}

#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UITableView *accountsTableView = [[UITableView alloc] initWithFrame:self.bounds];
        [accountsTableView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
        [self addSubview:accountsTableView];
        _accountsTableView = accountsTableView;
        
        [_accountsTableView setAccessibilityLabel:@"Accounts Table View"];
        

    }
    return self;
}

#pragma mark - Public methods

- (UITableView *)accountsTableView {
    return _accountsTableView;
}

@end
