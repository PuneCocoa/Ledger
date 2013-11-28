//
//  LedgerTests.m
//  LedgerTests
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LEDAccountStore.h"
#import "LEDAccount.h"
#import "LEDTransaction.h"

@interface LedgerTests : XCTestCase

@end

@implementation LedgerTests

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

- (void)testAccount
{

    LEDAccountStore *accountStore = [[LEDAccountStore alloc] init];

    double expectedBalance = 0;

    LEDAccount *testAccount1 = [LEDAccount accountWithName:@"Test1"];
    NSString *accountName = @"Test1";

    XCTAssertTrue([[testAccount1 name] isEqualToString:accountName], @"Account name incorrect");

    XCTAssertEqual([testAccount1 balance], expectedBalance, @"Account balance incorrect");
    [accountStore addAccount:testAccount1];

    LEDTransaction *transaction1 = [LEDTransaction transactionWithAmount:100 detail:@"Test transaction 1" date:[NSDate date]];
    [testAccount1 addTransaction:transaction1];
    expectedBalance += [transaction1 amount];
    XCTAssertEqual([testAccount1 balance], expectedBalance, @"Account balance incorrect");


    LEDTransaction *transaction2 = [LEDTransaction transactionWithAmount:-1000 detail:@"Test transaction 2" date:[NSDate date]];
    [testAccount1 addTransaction:transaction2];
    expectedBalance += [transaction2 amount];
    XCTAssertEqual([testAccount1 balance], expectedBalance, @"Account balance incorrect");


    [testAccount1 deleteTransaction:transaction2];
    expectedBalance -= [transaction2 amount];
    XCTAssertEqual([testAccount1 balance], expectedBalance, @"Account balance incorrect");

    [testAccount1 deleteAllTransactions];
    expectedBalance = 0;
    XCTAssertEqual([testAccount1 balance], expectedBalance, @"Account balance incorrect");




}

@end
