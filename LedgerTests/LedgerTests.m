//
//  LedgerTests.m
//  LedgerTests
//
//  Created by Harshad on 25/11/13.
//  Copyright (c) 2013 VXT. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LEDAccount.h"

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

- (void)testExample
{
    LEDAccount *anAccount = [LEDAccount accountWithName:@"Test"];
    double balance = 0;
    XCTAssertEqual([anAccount balance], balance, @"Account balance not correct");
}

@end
