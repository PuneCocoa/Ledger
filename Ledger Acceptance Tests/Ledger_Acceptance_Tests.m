//
//  Ledger_Acceptance_Tests.m
//  Ledger Acceptance Tests
//
//  Created by Harshad on 28/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import <KIF/KIF.h>

@interface Ledger_Acceptance_Tests : KIFTestCase

@end

@implementation Ledger_Acceptance_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAccounts
{
    [tester waitForViewWithAccessibilityLabel:@"Add Account Button"];

    [tester tapViewWithAccessibilityLabel:@"Add Account Button"];
    [tester waitForTimeInterval:0.3];

    [tester waitForViewWithAccessibilityLabel:@"Confirm"];

    NSString *accountName = @"Test";
    [tester enterTextIntoCurrentFirstResponder:accountName];
    [tester tapViewWithAccessibilityLabel:@"Confirm"];

    [tester waitForTimeInterval:0.4];
    [tester waitForViewWithAccessibilityLabel:[NSString stringWithFormat:@"Account %@", accountName]];

    [tester tapViewWithAccessibilityLabel:[NSString stringWithFormat:@"Account %@", accountName]];
    [tester waitForTimeInterval:0.3];
    [tester waitForViewWithAccessibilityLabel:@"Add Transaction Button"];

    [tester tapViewWithAccessibilityLabel:@"Add Transaction Button"];
    [tester  waitForTimeInterval:0.3];
    [tester waitForViewWithAccessibilityLabel:@"Add Transaction Alert Amount Field"];
    [tester waitForViewWithAccessibilityLabel:@"Add Transaction Alert Detail Field"];


    [tester enterText:@"100" intoViewWithAccessibilityLabel:@"Add Transaction Alert Amount Field"];
    [tester enterText:@"Test transaction" intoViewWithAccessibilityLabel:@"Add Transaction Alert Detail Field"];
    [tester tapViewWithAccessibilityLabel:@"Confirm"];

    [tester waitForTimeInterval:0.4];

    [tester waitForViewWithAccessibilityLabel:[NSString stringWithFormat:@"Account Detail Cell Amount %.2f", 100.0f]];
    [tester waitForViewWithAccessibilityLabel:[NSString stringWithFormat:@"Account Detail Cell Title %@", @"Test transaction"]];

    [tester tapViewWithAccessibilityLabel:@"Accounts"];
    [tester waitForTimeInterval:0.3f];

    [tester waitForViewWithAccessibilityLabel:[NSString stringWithFormat:@"Balance: %.2f", 100.0f]];




}

@end
