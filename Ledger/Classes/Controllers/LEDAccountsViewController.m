//
//  LEDAccountsViewController.m
//  Ledger
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDAccountsViewController.h"

#import "LEDAccountsView.h"
#import "LEDAccountStore.h"
#import "LEDAccount.h"
#import "LEDTransaction.h"

@interface LEDAccountsViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    LEDAccountStore *_accountStore;
}

- (void)touchAddAccount:(UIBarButtonItem *)barButtonItem;

@end

@implementation LEDAccountsViewController

#pragma mark - Initilisation

- (id)init {
    
    self = [super init];
    
    if (self != nil) {
        
        _accountStore = [[LEDAccountStore alloc] init];
        
        LEDAccount *anAccount = [LEDAccount accountWithName:@"Work"];
        [_accountStore addAccount:anAccount];
    }
    
    return self;
}

- (void)loadView {
    
    LEDAccountsView *aView = [[LEDAccountsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [aView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [self setView:aView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setTitle:@"Accounts"];
    
    LEDAccountsView *theView = (LEDAccountsView *)self.view;
    [[theView accountsTableView] setDataSource:self];
    [[theView accountsTableView] setDelegate:self];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(touchAddAccount:)];
    [addButton setAccessibilityLabel:@"Add Account Button"];
    [self.navigationItem setRightBarButtonItem:addButton];

}

#pragma mark - Actions

- (void)touchAddAccount:(UIBarButtonItem *)barButtonItem {
    
    LEDAccount *anAccount = [LEDAccount accountWithName:@"New Account"];
    [_accountStore addAccount:anAccount];
    
    LEDAccountsView *theView = (LEDAccountsView *)self.view;
    [[theView accountsTableView] reloadData];
    
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _accountStore.accounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *AccountsTableCellIdentifier = @"AccountsTableCellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountsTableCellIdentifier];

    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AccountsTableCellIdentifier];
        
    }
    
    LEDAccount *theAccount = [_accountStore.accounts objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:theAccount.name];
    [cell.textLabel setAccessibilityLabel:[NSString stringWithFormat:@"Account %@", theAccount.name]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"Balance: %.2f", theAccount.balance]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
