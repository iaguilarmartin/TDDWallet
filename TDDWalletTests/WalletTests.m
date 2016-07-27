//
//  WalletTests.m
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 21/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Money.h"
#import "Broker.h"
#import "Wallet.h"

@interface WalletTests : XCTestCase
@end

@implementation WalletTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

// €40 + $20 = $100 2:1
-(void) testAdditionWithReduction {
    
    Broker *broker = [Broker new];
    [broker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    Wallet *wallet = [[Wallet alloc] initWithAmount: 40 currency: @"EUR"];
    [wallet plus: [Money dollarWithAmount: 20]];
    
    Money *reduced = [broker reduce:wallet toCurrency:@"USD"];
    XCTAssertEqualObjects(reduced, [Money dollarWithAmount:100], @"€40 + $20 = $100 2:1");
}

-(void) testTotalMoneisForCurrencies {
    Wallet *wallet = [[Wallet alloc] initWithAmount: 40 currency: @"USD"];
    [wallet plus: [Money dollarWithAmount: 20]];
    
    XCTAssertEqual([wallet countOfMoneisForCurrency:@"USD"], 2, @"Count of moneys must be the same as the number of moneys added");
}

-(void) testGetMoneyForACurrency {
    Wallet *wallet = [[Wallet alloc] initWithAmount: 40 currency: @"USD"];
    Money *twenty = [Money dollarWithAmount: 20];
    [wallet plus: twenty];
    
    Money *money = [wallet getMoneyForCurrency:@"USD" atIndex:1];
    
    XCTAssertEqualObjects(money, twenty, @"Moneis inserted in wallet and retrieved must be the same");
}

-(void) testCalculateTotalMoneyForACurrency {
    Wallet *wallet = [[Wallet alloc] initWithAmount: 40 currency: @"EUR"];
    Money *twenty = [Money dollarWithAmount: 20];
    [wallet plus: twenty];
    
    Money *total = [wallet getTotalMoneyForCurrency:@"USD"];
    
    XCTAssertEqualObjects(total, twenty, @"€40 + $20 => Total USD: $20");

}

-(void) testGetACurrencyInIndex {
    Wallet *wallet = [[Wallet alloc] initWithAmount: 40 currency: @"EUR"];
    [wallet plus: [Money dollarWithAmount: 20]];
    
    XCTAssertEqualObjects([wallet getCurrencyAtIndex:0], @"EUR", @"Index of currencies must be in the same position as when they were added");
    XCTAssertEqualObjects([wallet getCurrencyAtIndex:1], @"USD", @"Index of currencies must be in the same position as when they were added");
}

@end
