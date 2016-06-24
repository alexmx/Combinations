//
//  CombinationsGenerator.swift
//  Combinations
//
//  Created by Alexandru Maimescu on 6/14/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import Foundation

public typealias Matrix = Array<Array<AnyObject>>

@objc
public final class CombinationsGenerator: NSObject {
    
    func cartesianProduct(matrix: Matrix) -> Matrix {
        
        let productSize = matrix.reduce(1) { $0 * $1.count }
        
        var product = Matrix()
        for i in 0..<productSize {
            var cross = [AnyObject]()
            var n = i
            for row in matrix.reverse() {
                cross.append(row[n % row.count])
                n /= row.count
            }
            product.append(cross.reverse())
        }
        
        return product
    }
    
    /**
     Generate combinations for provided input values.
     
     - parameter values: The input values used to generate combinations.
     
     - returns: A matrix of generated combinations.
     */
    public func combinations(forValues values: Matrix) -> Matrix {
        return cartesianProduct(values)
    }
    
    /**
     Generate combinations for provided input values.
     
     - parameter inputValues: The input values used to generate combinations.
     - parameter assertCombination: The closure which will be invoked for every generated combination.
     */
    public func combinations(forValues values: Matrix, assertCombination: ([AnyObject]) -> Void) {
        combinations(forValues: values).forEach { (combination) in
            assertCombination(combination)
        }
    }
    
    /**
     Generate combinations for provided input values.
     
     - parameter values: The input values used to generate combinations.
     - parameter assertCombination: The closure which will be invoked for every generated combination.
     */
    public static func combinations(forValues values: Matrix, assertCombination: ([AnyObject]) -> Void) {
        CombinationsGenerator().combinations(forValues: values, assertCombination: assertCombination)
    }
}