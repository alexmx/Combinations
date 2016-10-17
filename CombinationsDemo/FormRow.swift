//
//  FormRow.swift
//  Combinations
//
//  Created by Alexandru Maimescu on 6/20/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import Foundation

protocol Validatable {
    
    func validate() throws
}

enum FormRowValidationError: Error {
    
    case mandatoryField(fieldName: String)
    case incorrectFormat(fieldName: String)
}

enum FormRowValueType: UInt {
    
    case genericAlphanumeric
    case genericNumeric
    case email
    case passcode
    case multipleChoice
}

class FormRow {
    
    var rowType: FormRowValueType = .genericAlphanumeric
    
    var title: String?
    var placeholder: String?
    var value: String?
    
    var maximumLength: UInt = 0
    
    var values: [String]? {
        
        didSet {
            value = values?[selectedValueIndex]
        }
    }
    
    var selectedValueIndex: Int = 0 {
        
        didSet {
            value = values?[selectedValueIndex]
        }
    }
    
    var editable: Bool = true
    var optional: Bool = false
    
    var tag: UInt?
    
    convenience init(title: String?, value: String?) {
        
        self.init()
        
        self.title = title
        self.value = value
    }
    
    convenience init(title: String?, values: [String]) {
        
        self.init(title: title, value: nil)
        
        self.rowType = .multipleChoice
        self.values = values
        self.value = values[selectedValueIndex]
    }
}

extension FormRow: Validatable {
    
    func validate() throws {
        
        guard optional == false else {
            return
        }
        
        guard let value = value, !value.isEmpty else {
            throw FormRowValidationError.mandatoryField(fieldName: title ?? "unknown")
        }
    }
}
