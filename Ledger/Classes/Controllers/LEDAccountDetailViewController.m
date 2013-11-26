//
//  LEDAccountDetailViewController.m
//  Ledger
//
//  Created by Harshad on 26/11/2013.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDAccountDetailViewController.h"
#import "LEDAccountDetailView.h"

#import "LEDAccount.h"
#import "LEDTransaction.h"

@interface LEDAccountDetailViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    __weak LEDAccountDetailView *_accountDetailView;
}

@end

@implementation LEDAccountDetailViewController

#pragma mark - Initialisation

- (instancetype)initWithAccount:(LEDAccount *)account {
    
    self = [super init];
    if (self != nil) {
        
        _account = account;
        
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    
    LEDAccountDetailView *aView = [[LEDAccountDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [aView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self setView:aView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:[_account name]];
    
    if ([self.view isKindOfClass:[LEDAccountDetailView class]]) {
        _accountDetailView = (LEDAccountDetailView *)self.view;
    } else {
        _accountDetailView = nil;
    }

    
    [[_accountDetailView transactionsTableView] setDataSource:self];
    [[_accountDetailView transactionsTableView] setDelegate:self];
    
}

- (void)setView:(UIView *)view {
    
    [super setView:view];
    
    if ([view isKindOfClass:[LEDAccountDetailView class]]) {
        
        _accountDetailView = (LEDAccountDetailView *)view;
        
    } else {
        
        _accountDetailView = nil;
        
        NSLog(@"%@ warning: view is not of type %@", [self class], [LEDAccountDetailView class]);
    }
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_account transactions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *AccountDetailTableCellIdentifier = @"AccountDetailTableCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountDetailTableCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AccountDetailTableCellIdentifier];
    }
    
    LEDTransaction *theTransaction = [_account transactions][[indexPath row]];
    
    [cell.textLabel setText:[theTransaction detail]];
    [cell.textLabel setAccessibilityLabel:[NSString stringWithFormat:@"Account Detail Cell Title %@", [theTransaction detail]]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%.2f", [theTransaction amount]]];
    [cell.detailTextLabel setAccessibilityLabel:[NSString stringWithFormat:@"Account Detail Cell Amount %.2f", [theTransaction amount]]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}


@end
