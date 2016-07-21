//
//  Money.m
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 20/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import "Money.h"
#import "Broker.h"

@interface Money()
@property (nonatomic, strong) NSNumber *amount;
@end

@implementation Money

+(id) euroWithAmount: (NSInteger) amount {
    return [[Money alloc] initWithAmount:amount currency:@"EUR"];
}

+(id) dollarWithAmount: (NSInteger) amount {
    return [[Money alloc] initWithAmount:amount currency:@"USD"];
}

-(id) initWithAmount: (NSInteger) amount currency:(NSString *)currency {
    if (self = [super init]) {
        _amount = @(amount);
        _currency = currency;
    }
    
    return self;
}

/*-(Money*) times: (NSInteger) multiplier {
    
    // no se deberia de llamar, sino que se deberia
    // de usar el de la subclase

    return [self subclassResponsibility:_cmd];
}*/

-(id<Money>) times: (NSInteger) multiplier {
    Money *newMoney = [[Money alloc] initWithAmount:[self.amount integerValue] * multiplier currency:self.currency];
    return newMoney;
}

-(id<Money>) plus: (Money *) other {
    NSInteger totalAmount = [self.amount integerValue] + [other.amount integerValue];
    Money *total = [[Money alloc] initWithAmount:totalAmount currency:self.currency];
    return total;
}

-(Money *) reduceToCurrency: (NSString*) currency
                 withBroker: (Broker *) broker {
    
    Money * result;
    double rate = [[broker.rates objectForKey:[broker keyFromCurrency:self.currency toCurrency:currency]] doubleValue];
    
    // Comprobamos que divisa de origen y destino son las mismas
    if ([[self currency] isEqual:currency]) {
        result = self;
    } else if(rate == 0) {
        // NO hay tasa de conversión, excepcion que te crio
        [NSException raise:@"NoConversionRateException" format:@"Must hace a conversion from %@ to %@", self.currency, currency];
    } else {
        NSInteger newAmount = [self.amount integerValue] * rate;
        
        result = [[Money alloc] initWithAmount:newAmount currency:currency];
    }
    
    return result;
}


#pragma mark - Overwritten

-(BOOL)isEqual:(id)object {
    return [self amount] == [object amount] && [[self currency] isEqual:[object currency]];
}

-(NSString *) description {
    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], self.currency, self.amount];
}

-(NSUInteger) hash {
    return [self.amount integerValue];
}

@end
