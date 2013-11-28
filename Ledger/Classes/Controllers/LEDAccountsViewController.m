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
#import "LEDAccountDetailViewController.h"

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

- (void)setView:(UIView *)view {
    
    [super setView:view];
    
    if ([view isKindOfClass:[LEDAccountsView class]]) {
        
        _accountsView = (LEDAccountsView *)self.view;
        
    } else {
        
        _accountsView = nil;
        
        NSLog(@"%@ warning: View is not of type %@", NSStringFromClass([self class]), NSStringFromClass([LEDAccountsView class]));
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Accounts"];
    
    if ([self.view isKindOfClass:[LEDAccountsView class]]) {
        
        _accountsView = (LEDAccountsView *)self.view;
    } else {
        _accountsView = nil;
    }

    
    [[_accountsView accountsTableView] setDataSource:self];
    [[_accountsView accountsTableView] setDelegate:self];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(touchAddAccount:)];
    [addButton setAccessibilityLabel:@"Add Account Button"];
    [self.navigationItem setRightBarButtonItem:addButton];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[_accountsView accountsTableView] reloadData];
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

    [cell setAccessibilityLabel:[NSString stringWithFormat:@"Account %@", theAccount.name]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"Balance: %.2f", theAccount.balance]];

    [cell.detailTextLabel setAccessibilityLabel:cell.detailTextLabel.text];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LEDAccount *theAccount = [_accountStore.accounts objectAtIndex:indexPath.row];
    
    LEDAccountDetailViewController *accountDetailViewController = [[LEDAccountDetailViewController alloc] initWithAccount:theAccount store:_accountStore];
    [self.navigationController pushViewController:accountDetailViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
            [_accountStore save];
            
            [[_accountsView accountsTableView] reloadData];

        }
    }
}


@end
