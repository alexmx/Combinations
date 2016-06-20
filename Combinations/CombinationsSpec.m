//
//  CombinationsSpec.m
//  Combinations
//
//  Created by Alexandru Maimescu on 6/14/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

@import Foundation;

#import <Combinations/Combinations-Swift.h>
#import <objc/runtime.h>

#import "CombinationsSpec.h"

@interface CombinationsSpec ()

@end

@implementation CombinationsSpec

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

+ (Matrix *)inputValuesForCombinations
{
    [self raiseOverrideRequired]; // Must be overridden
    
    return nil;
}

+ (NSArray<NSInvocation *> *)testInvocations
{
    if (self == [CombinationsSpec self]) return nil;
    
    Matrix *inputValues = [self inputValuesForCombinations];
    Matrix *combinations = [[CombinationsGenerator new] combinationsForInputValues:inputValues];
    
    NSMutableArray *invocations = [NSMutableArray arrayWithCapacity:combinations.count];
    
    for (int i = 0; i < combinations.count; i++) {
        NSString *combinationIdentifier = [NSString stringWithFormat:@"comb_%d", i];
        [invocations addObject:[self invocationWithIdentifier:combinationIdentifier combination:combinations[i]]];
    }
    
    return invocations;
}

+ (NSInvocation *)invocationWithIdentifier:(NSString *)identifier combination:(NSArray *)combination
{
    SEL selector = [self addInstanceMethodForIdentifier:identifier combination:combination];
    
    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = selector;
    
    return invocation;
}

+ (SEL)addInstanceMethodForIdentifier:(NSString *)identifier combination:(NSArray *)combination
{
    NSString *selectorName = [NSString stringWithFormat:@"%@_%@", NSStringFromClass(self), identifier];
    SEL selector = NSSelectorFromString(selectorName);
    
    IMP implementation = imp_implementationWithBlock(^(CombinationsSpec *self) {
        [self assertCombination:combination];
    });
    
    NSString *typeString = [NSString stringWithFormat:@"%s%s%s",  @encode(id), @encode(id), @encode(SEL)];
    class_addMethod(self, selector, implementation, typeString.UTF8String);
    
    return selector;
}

+ (void)raiseOverrideRequired
{
    [NSException raise:@"Fatal Error"
                format:@"This method must be overridden in subclass!"];
}

- (void)raiseOverrideRequired
{
    [self.class raiseOverrideRequired];
}

- (void)assertCombination:(NSArray *)combination
{
    [self raiseOverrideRequired]; // Must be overridden
}

@end
