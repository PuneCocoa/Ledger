//
//  LEDAccountsViewController.m
//  Ledger
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import "LEDAccountsViewController.h"
#import "LEDAccountsView.h"

@interface LEDAccountsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation LEDAccountsViewController

- (void)loadView {
    LEDAccountsView *aView = [[LEDAccountsView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [aView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [self setView:aView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    LEDAccountsView *theView = (LEDAccountsView *)self.view;
    [[theView accountsTableView] setDataSource:self];
    [[theView accountsTableView] setDelegate:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    _accounts = nil;
}

#pragma mark - Getters

- (NSArray *)accounts {

    if (_accounts == nil) {
        _accounts = [NSArray new];
    }

    return _accounts;
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.accounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *AccountsTableCellIdentifier = @"AccountsTableCellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountsTableCellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccountsTableCellIdentifier];
    }

    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
