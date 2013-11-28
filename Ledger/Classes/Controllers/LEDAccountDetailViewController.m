//
//  LEDAccountDetailViewController.m
//  Ledger
//
//  Created by Harshad on 26/11/2013.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDAccountDetailViewController.h"
#import "LEDAccountDetailView.h"

#import "LEDAccountStore.h"
#import "LEDAccount.h"
#import "LEDTransaction.h"

@interface LEDAccountDetailViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    
    __weak LEDAccountDetailView *_accountDetailView;
}

- (void)touchAddTransaction:(UIBarButtonItem *)barButton;

@end

@implementation LEDAccountDetailViewController

#pragma mark - Initialisation

- (instancetype)initWithAccount:(LEDAccount *)account store:(LEDAccountStore *)accountStore {
    
    self = [super init];
    if (self != nil) {
        
        _account = account;
        _accountStore = accountStore;

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
    
    [self setTitle:[NSString stringWithFormat:@"Transactions - %@", [_account name]]];
    
    if ([self.view isKindOfClass:[LEDAccountDetailView class]]) {
        _accountDetailView = (LEDAccountDetailView *)self.view;
    } else {
        _accountDetailView = nil;
    }
    
    [[_accountDetailView transactionsTableView] setDataSource:self];
    [[_accountDetailView transactionsTableView] setDelegate:self];

    UIBarButtonItem *addTransactionButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(touchAddTransaction:)];
    [self.navigationItem setRightBarButtonItem:addTransactionButton];
    [addTransactionButton setAccessibilityLabel:@"Add Transaction Button"];
    
}

- (void)setView:(UIView *)view {
    
    [super setView:view];
    
    if ([view isKindOfClass:[LEDAccountDetailView class]]) {
        
        _accountDetailView = (LEDAccountDetailView *)view;
        
    } else {
        
        _accountDetailView = nil;
        
        NSLog(@"%@ warning: view is not of type %@", NSStringFromClass([self class]), NSStringFromClass([LEDAccountDetailView class]));
    }
}

#pragma mark - Actions

- (void)touchAddTransaction:(UIBarButtonItem *)barButton {

    UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:@"Add Transaction" message:@"Enter transaction amount and details" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    [anAlertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];

    UITextField *amountField = [anAlertView textFieldAtIndex:0];
    UITextField *detailField = [anAlertView textFieldAtIndex:1];

    [amountField setPlaceholder:@"Amount"];
    [amountField setAccessibilityLabel:@"Add Transaction Alert Amount Field"];

    [detailField setPlaceholder:@"Detail"];
    [detailField setSecureTextEntry:NO];
    [detailField setAccessibilityLabel:@"Add Transaction Alert Detail Field"];

    [anAlertView setAccessibilityLabel:@"Add Transaction Alert"];

    [anAlertView show];

}


#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.account transactions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *AccountDetailTableCellIdentifier = @"AccountDetailTableCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountDetailTableCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AccountDetailTableCellIdentifier];
    }
    
    LEDTransaction *theTransaction = [self.account transactions][[indexPath row]];
    
    [cell.textLabel setText:[theTransaction detail]];
    
    [cell setAccessibilityLabel:[NSString stringWithFormat:@"Account Detail Cell Title %@", [theTransaction detail]]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%.2f", [theTransaction amount]]];
    [cell.detailTextLabel setAccessibilityLabel:[NSString stringWithFormat:@"Account Detail Cell Amount %.2f", [theTransaction amount]]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}

#pragma mark - UIAlertViewDelegate methods

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {

    BOOL shouldEnable = YES;

    if (alertView.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {

        UITextField *amountField = [alertView textFieldAtIndex:0];
        UITextField *detailField = [alertView textFieldAtIndex:1];

        if (detailField.text.length == 0 || [amountField.text doubleValue] == 0) {
            shouldEnable = NO;
        }
    }

    return shouldEnable;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if (alertView.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {

        if (buttonIndex == 1) {

            UITextField *amountField = [alertView textFieldAtIndex:0];
            UITextField *detailField = [alertView textFieldAtIndex:1];

            LEDTransaction *aTransaction = [LEDTransaction transactionWithAmount:[amountField.text doubleValue] detail:detailField.text date:[NSDate date]];

            [self.account addTransaction:aTransaction];

            [self.accountStore save];

            [[_accountDetailView transactionsTableView] reloadData];


        }
    }
}


@end
