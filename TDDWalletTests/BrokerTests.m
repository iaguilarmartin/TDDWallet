//
//  BrokerTests.m
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 21/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Money.h"
#import "Broker.h"

@interface BrokerTests : XCTestCase
@property (nonatomic, strong) Broker *emptyBroker;
@property (nonatomic, strong) Money *oneDollar;
@end

@implementation BrokerTests

- (void)setUp {
    [super setUp];
    
    self.emptyBroker = [Broker new];
    self.oneDollar = [Money dollarWithAmount:1];
}

- (void)tearDown {
    [super tearDown];
    
    self.emptyBroker = nil;
    self.oneDollar = nil;
}

-(void) testSimpleReduction {
    Money *sum = [[Money dollarWithAmount:5] plus:[Money dollarWithAmount:5]];
    
    Money *reduced = [self.emptyBroker reduce: sum toCurrency: @"USD"];
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency should be a NOP");
}

// $10 == €5 2:1
-(void) testReduction {
    [self.emptyBroker addRate: 2 fromCurrency: @"EUR" toCurrency: @"USD"];
    
    Money *dollars = [Money dollarWithAmount:10];
    Money *euros = [Money euroWithAmount:5];
    
    Money *converted = [self.emptyBroker reduce:dollars toCurrency:@"EUR"];
    XCTAssertEqualObjects(converted, euros, @"$10 == €5 2:1");
}

-(void) testThatNoRateRaisesException {
    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar toCurrency:@"EUR"], @"No rates should cause exception");
}

-(void) testThatNilConversionDoesNotChangeMoney {
    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduce:self.oneDollar toCurrency:@"USD"], @"A nil conversion should have no effect");
}

@end
