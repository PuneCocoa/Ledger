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

@interface LEDAccountsViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    
    LEDAccountStore *_accountStore;
    
    __weak LEDAccountsView *_accountsView;
}

- (void)touchAddAccount:(UIBarButtonItem *)barButtonItem;

@end

@implementation LEDAccountsViewController

#pragma mark - Initilisation

- (id)init {
    
    self = [super init];
    
    if (self != nil) {
        
        _accountStore = [[LEDAccountStore alloc] init];
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
    
    _accountsView = (LEDAccountsView *)self.view;
    
    [[_accountsView accountsTableView] setDataSource:self];
    [[_accountsView accountsTableView] setDelegate:self];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(touchAddAccount:)];
    [addButton setAccessibilityLabel:@"Add Account Button"];
    [self.navigationItem setRightBarButtonItem:addButton];

}

#pragma mark - Actions

- (void)touchAddAccount:(UIBarButtonItem *)barButtonItem {
    
    UIAlertView *accountNameAlertView = [[UIAlertView alloc] initWithTitle:@"Account Name" message:@"Enter a name for this account" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    
    [accountNameAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [accountNameAlertView setAccessibilityLabel:@"Account Name Alert"];
    
    [accountNameAlertView show];
    
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

#pragma mark - UIAlertViewDelegate methods

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    
    BOOL shouldEnable = YES;
    
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
        
        shouldEnable = NO;
        
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        if (textField.text.length > 0) {
            
            shouldEnable = YES;
        }
    }
    
    return shouldEnable;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        UITextField *accountNameField = [alertView textFieldAtIndex:0];
        
        NSString *accountName = accountNameField.text;
        
        if (accountName.length > 0) {
            
            LEDAccount *anAccount = [LEDAccount accountWithName:accountName];
            
            [_accountStore addAccount:anAccount];
            
            [[_accountsView accountsTableView] reloadData];
            
        }
    }
}


@end
