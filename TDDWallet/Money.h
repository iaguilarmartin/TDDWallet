//
//  Money.h
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 20/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Broker;
@class Money;

@protocol Money <NSObject>

-(id) initWithAmount: (NSInteger) amount
            currency: (NSString *) currency;
-(id<Money>) times: (NSInteger) multiplier;
-(id<Money>) plus: (Money *) other;
-(Money *) reduceToCurrency: (NSString*) currency
                 withBroker: (Broker *) broker;

@end

@interface Money : NSObject<Money>

@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, readonly) NSString *currency;

+(id) euroWithAmount: (NSInteger) amount;
+(id) dollarWithAmount: (NSInteger) amount;

@end
