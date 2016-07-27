//
//  Wallet.m
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 21/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import "Wallet.h"
@import UIKit;

@interface Wallet()

@property (nonatomic, strong) NSMutableArray *moneys;
@property (nonatomic, strong) NSMutableArray *currencies;
@end

@implementation Wallet

-(NSInteger) count {
    return self.moneys.count;
}

-(NSInteger) currenciesCount {
    return _currencies.count;
}

-(id) initWithAmount:(NSInteger)amount currency:(NSString *)currency {
    
    if (self = [super init]) {
        Money *money = [[Money alloc] initWithAmount:amount currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
        
        _currencies = [NSMutableArray array];
        [_currencies addObject:currency];
    }
    
    return self;
}

-(id<Money>) plus: (Money *) other {
    [self.moneys addObject:other];
    
    if (![self.currencies containsObject:other.currency]) {
        [self.currencies addObject:other.currency];
    }
    
    return self;
}

-(id<Money>) times: (NSInteger) multiplier {
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity:self.moneys.count];
    
    for (Money *each in self.moneys) {
        Money *newMoney = [each times:multiplier];
        [newMoneys addObject:newMoney];
    }
    
    self.moneys = newMoneys;
    return self;
}

-(Money *) reduceToCurrency: (NSString*) currency
                 withBroker: (Broker *) broker {
    
    Money *result = [[Money alloc] initWithAmount:0 currency:currency];
    
    for (Money *each in self.moneys) {
        result = [result plus:[each reduceToCurrency:currency withBroker:broker]];
    }
    
    return result;
}

-(Money *) getTotalMoneyForCurrency: (NSString *) currency {
    Money *result = [[Money alloc] initWithAmount:0 currency:currency];
    
    for (Money *each in self.moneys) {
        if ([each.currency isEqual:currency]) {
            result = [result plus: each];
        }
    }
    
    return result;
}

-(NSInteger) countOfMoneisForCurrency: (NSString *) currency {
    NSInteger total = 0;
    
    for (Money *each in self.moneys) {
        if ([each.currency isEqual:currency]) {
            total = total + 1;
        }
    }
    
    return total;
}

-(NSString *) getCurrencyAtIndex: (NSInteger) index {
    return [self.currencies objectAtIndex:index];
}

-(Money *) getMoneyForCurrency: (NSString *) currency
                       atIndex: (NSInteger) index {
    
    NSInteger currentIndex = 0;
    
    for (Money *each in self.moneys) {
        if ([each.currency isEqual:currency]) {
            if (index == currentIndex) {
                return each;
            } else {
                currentIndex++;
            }
        }
    }
    
    return nil;
}

#pragma mark - Notification

-(void) subscribeToMemoryWarning: (NSNotificationCenter *) nc {
    
    [nc addObserver:self selector:@selector(dumpToDisk:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

-(void) dumpToDisk: (NSNotification *) notification {
    
}

@end
