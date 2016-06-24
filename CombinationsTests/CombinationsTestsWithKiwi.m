//
//  CombinationsTestsWithKiwi.m
//  Combinations
//
//  Created by Alexandru Maimescu on 6/24/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>

@import Combinations;

SPEC_BEGIN(CombinationsAdditiveTests)

describe(@"CombinationsAdditiveTests", ^{
    
    context(@"a state the component is in", ^{
        
        NSArray *inputValues = @[@[@1, @2], @[@"1", @"2"]];
        
        [CombinationsGenerator combinationsForValues:inputValues assertCombination:^(NSArray * _Nonnull combination) {
            
            it(@"should do something", ^{
                // Perform required asserts on combination 
            });
        }];
    });
});

SPEC_END
