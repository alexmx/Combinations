//
//  CombinationsSpec.h
//  Combinations
//
//  Created by Alexandru Maimescu on 6/14/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

#import <XCTest/XCTest.h>

typedef NSArray<NSArray *> Matrix;

/**
 *  The base class for generated combinations tests.
 */
@interface CombinationsSpec : XCTestCase

/**
 *  Get input values which will be used to generate combinations.
 *
 *  @discussion This method must be overriden.
 *
 *  @return A matrix of input values.
 */
+ (nullable Matrix *)inputValuesForCombinations;

/**
 *  Assert the generated combination of values.
 *
 *  @discussion This method will be called for each generated combination and a new test will be added in run-time.
 *  This method must be overriden.
 *
 *  @param combination The combination to be asserted.
 */
- (void)assertCombination:(nonnull NSArray *)combination;

@end