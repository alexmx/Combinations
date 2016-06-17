//
//  CombinationsGenerator.swift
//  Combinations
//
//  Created by Alexandru Maimescu on 6/14/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import Foundation

public typealias ValuesCollection = Array<Array<AnyObject>>

@objc
public final class CombinationsGenerator: NSObject {
    
    func cartesianProduct(matrix: ValuesCollection) -> ValuesCollection {
        
        let productSize = matrix.reduce(1) { $0 * $1.count }
        
        var product = ValuesCollection()
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
    
    public func combinations(forValuesCollection valuesCollection: ValuesCollection) -> ValuesCollection {
        return cartesianProduct(valuesCollection)
    }
}