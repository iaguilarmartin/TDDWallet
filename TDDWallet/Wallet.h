//
//  Wallet.h
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 21/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Money.h"

@interface Wallet : NSObject<Money>
@property (nonatomic, readonly) NSInteger count;

-(void) subscribeToMemoryWarning: (NSNotificationCenter *) nc;
@end
