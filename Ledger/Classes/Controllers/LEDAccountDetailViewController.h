//
//  LEDAccountDetailViewController.h
//  Ledger
//
//  Created by Harshad on 26/11/2013.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LEDAccount;
@class LEDAccountStore;

@interface LEDAccountDetailViewController : UIViewController

- (instancetype)initWithAccount:(LEDAccount *)account store:(LEDAccountStore *)accountStore;

@property (strong, nonatomic) LEDAccount *account;
@property (strong, nonatomic) LEDAccountStore *accountStore;

@end
