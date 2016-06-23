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
    
    override class func valuesForCombinations() -> Matrix {
        return [
            [1, 2, 3, 4],
            ["1", "2", "3"]
        ]
    }
    
    override func assertCombination(combination: [AnyObject]) {
        
        print(combination)
        
        // Perform required asserts on combination
        
        XCTAssertTrue(true)
    }
}


class CombinationTests2: CombinationsSpec {
    
    override class func valuesForCombinations() -> Matrix {
        
        return [
            [1, 2],
            ["hello", "world"]
        ]
    }
    
    override func assertCombination(combination: [AnyObject]) {
        
        print(combination)
        
        // Perform required asserts on combination
        
        XCTAssertTrue(true)
    }
}
