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

@end

@implementation Wallet

-(NSInteger) count {
    return self.moneys.count;
}

-(id) initWithAmount:(NSInteger)amount currency:(NSString *)currency {
    
    if (self = [super init]) {
        Money *money = [[Money alloc] initWithAmount:amount currency:currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject:money];
    }
    
    return self;
}

-(id<Money>) plus: (Money *) other {
    [self.moneys addObject:other];
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

#pragma mark - Notification

-(void) subscribeToMemoryWarning: (NSNotificationCenter *) nc {
    
    [nc addObserver:self selector:@selector(dumpToDisk:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

-(void) dumpToDisk: (NSNotification *) notification {
    
}

@end
