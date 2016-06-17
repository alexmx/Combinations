//
//  CombinationsSpec.m
//  Combinations
//
//  Created by Alexandru Maimescu on 6/14/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Combinations/Combinations-Swift.h>
#import <objc/runtime.h>

#import "CombinationsSpec.h"

@import Foundation;

@interface CombinationsSpec ()

@end

@implementation CombinationsSpec

+ (void)initialize
{
    if (self == [CombinationsSpec self]) return;
}

+ (instancetype)testCaseWithSelector:(SEL)selector
{
    NSArray<NSInvocation *> *invocations = [self testInvocations];
    for (NSInvocation *invocation in invocations) {
        if (invocation.selector == selector) {
            return [super testCaseWithSelector:selector];
        }
    }
    
    return nil;
}

+ (NSArray<NSInvocation *> *)testInvocations
{
    if (self == [CombinationsSpec self]) return nil;
    
    NSInvocation *invocation = [self invocationWithIdentifier:@"mySuperTest"];
    
    return @[invocation];
}

+ (NSInvocation *)invocationWithIdentifier:(NSString *)identifier
{
    SEL selector = [self addInstanceMethodForIdentifier:identifier];
    
    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = selector;
    
    return invocation;
}

+ (SEL)addInstanceMethodForIdentifier:(NSString *)identifier
{
    SEL selector = NSSelectorFromString(identifier);
    
    IMP implementation = imp_implementationWithBlock(^(CombinationsSpec *self, NSArray *combination) {
        [self assertCombination:combination];
    });
    
    NSString *typeString = [NSString stringWithFormat:@"%s%s%s",  @encode(id), @encode(id), @encode(SEL)];
    class_addMethod(self, selector, implementation, typeString.UTF8String);
    
    return selector;
}

- (void)raiseOverrideRequired
{
    [NSException raise:@"Fatal Error"
                format:@"This method must be overridden in subclass!"];
}

- (void)assertCombination:(NSArray *)combination
{
    [self raiseOverrideRequired]; // Must be overridden
}

@end
