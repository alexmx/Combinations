//
//  CombinationsSpec.h
//  Combinations
//
//  Created by Alexandru Maimescu on 6/14/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

#import <XCTest/XCTest.h>

typedef NSArray<NSArray *> ValuesCollection;

@interface CombinationsSpec : XCTestCase

- (void)assertCombination:(nonnull NSArray *)combination;

@end
