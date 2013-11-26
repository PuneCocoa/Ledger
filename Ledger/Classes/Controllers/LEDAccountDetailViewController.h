//
//  LEDAccountDetailViewController.h
//  Ledger
//
//  Created by Harshad on 26/11/2013.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LEDAccount;

@interface LEDAccountDetailViewController : UIViewController

- (instancetype)initWithAccount:(LEDAccount *)account;

@property (strong, nonatomic) LEDAccount *account;

@end
