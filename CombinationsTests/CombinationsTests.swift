//
//  CombinationsTests.swift
//  CombinationsTests
//
//  Created by Alexandru Maimescu on 6/14/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import XCTest
@testable import Combinations

class CombinationTests1: CombinationsSpec {
    
    override class func inputValuesForCombinations() -> Matrix {
        
        return [
            [1, 2, 3, 4],
            ["1", "2", "3"]
        ]
    }
    
    override func assertCombination(combination: [AnyObject]) {
        
        XCTAssertTrue(true)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

class CombinationTests2: CombinationsSpec {
    
    override class func inputValuesForCombinations() -> Matrix {
        
        return [
            [1, 2],
            ["hello", "world"]
        ]
    }
    
    override func assertCombination(combination: [AnyObject]) {
        
        XCTAssertTrue(true)
    }
}
