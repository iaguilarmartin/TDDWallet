//
//  NSObject+GNUStepAddons.m
//  TDDWallet
//
//  Created by Ivan Aguilar Martin on 20/7/16.
//  Copyright © 2016 Ivan Aguilar Martin. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+GNUStepAddons.h"

@implementation NSObject (GNUStepAddons)

-(id) subclassResponsibility: (SEL)aSel {
    char prefix = class_isMetaClass(object_getClass(self)) ? '+':'-';
    
    [NSException raise:NSInvalidArgumentException format:@"%@%c%@ should be overriden by its subclass", NSStringFromClass([self class]), prefix, NSStringFromSelector(aSel)];
    
    return self;
}

@end
