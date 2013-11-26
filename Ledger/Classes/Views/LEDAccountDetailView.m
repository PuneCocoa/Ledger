//
//  LEDAccountDetailView.m
//  Ledger
//
//  Created by Harshad on 26/11/2013.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDAccountDetailView.h"

@implementation LEDAccountDetailView {
    
    __weak UITableView *_transactionsTableView;
}

#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITableView *transactionsTableView = [[UITableView alloc] initWithFrame:self.bounds];
        [transactionsTableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [self addSubview:transactionsTableView];
        
        _transactionsTableView = transactionsTableView;
    }
    return self;
}

#pragma mark - Public methods

- (UITableView *)transactionsTableView {
    
    return _transactionsTableView;
}
@end
