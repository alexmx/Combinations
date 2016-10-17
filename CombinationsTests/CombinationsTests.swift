//
//  CombinationsTests.swift
//  CombinationsTests
//
//  Created by Alexandru Maimescu on 6/14/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import XCTest
import Combinations

class CombinationTests1: CombinationsSpec {
    
    override func setUp() {
        super.setUp()
    }
    
    override class func valuesForCombinations() -> [[Any]]? {
        return [
            [1, 2, 3, 4],
            ["1", "2", "3"],
            [1, 2, 3, 4],
            ["1", "2", "3"]
        ]
    }
    
    override func assertCombination(_ combination: [Any]) {
        
        print(combination)
        
        // Perform required asserts on combination
        
        XCTAssertTrue(true)
    }
}


class CombinationTests2: CombinationsSpec {
    
    override class func valuesForCombinations() -> [[Any]]? {
        
        return [
            [1, 2],
            ["hello", "world"]
        ]
    }
    
    override func assertCombination(_ combination: [Any]) {
        
        if let number = combination[0] as? Int,
            let string = combination[1] as? String {
            
            print("\(number) \(string)")
        }
        
        // Perform required asserts on combination
        
        XCTAssertTrue(true)
    }
}
