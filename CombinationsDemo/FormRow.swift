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

enum FormRowValidationError: ErrorType {
    
    case MandatoryField(fieldName: String)
    case IncorrectFormat(fieldName: String)
}

enum FormRowValueType: UInt {
    
    case GenericAlphanumeric
    case GenericNumeric
    case Email
    case Passcode
    case MultipleChoice
}

class FormRow {
    
    var rowType: FormRowValueType = .GenericAlphanumeric
    
    var title: String?
    var placeholder: String?
    var value: String?
    
    var maximumLength: UInt = 0
    
    var values: Array<String>? {
        
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
    
    convenience init(title: String?, values: Array<String>) {
        
        self.init(title: title, value: nil)
        
        self.values = values
        self.value = values[selectedValueIndex]
    }
}

extension FormRow: Validatable {
    
    func validate() throws {
        
        guard optional == false else {
            return
        }
        
        guard let value = value where !value.isEmpty else {
            throw FormRowValidationError.MandatoryField(fieldName: title ?? "unknown")
        }
    }
}