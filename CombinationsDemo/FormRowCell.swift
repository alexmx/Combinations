//
//  FormRowCell.swift
//  Combinations
//
//  Created by Alexandru Maimescu on 6/20/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import UIKit


protocol FormRowCellInputAccessoryDelegate: class {
    
    func formRowCellDidPressPreviousButton(cell: FormRowCell)
    func formRowCellDidPressNextButton(cell: FormRowCell)
    func formRowCellDidPressDoneButton(cell: FormRowCell)
}


class FormRowCell: UITableViewCell {
    
    weak var inputAccessoryDelegate: FormRowCellInputAccessoryDelegate?
    
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var textField: UITextField?
    
    var formRow: FormRow? {
        
        didSet {
            
            guard let formRow = formRow else {
                return
            }
            
            titleLabel?.text = formRow.title
            
            if let textField = textField {
                
                textField.text = formRow.value
                textField.placeholder = formRow.placeholder
                textField.inputView = nil
                
                switch formRow.rowType {
                case .Passcode:
                    textField.secureTextEntry = true
                case .MultipleChoice:
                    textField.inputView = optionsView
                    textField.text = formRow.values?[defaultMultipleChoiceIndex]
                case .Email:
                    textField.autocapitalizationType = .None
                    textField.keyboardType = .EmailAddress
                default:
                    textField.keyboardType = .Default
                }
            }
        }
    }
    
    var editable: Bool = true {
        
        didSet {
            textField?.enabled = editable
        }
    }
    
    private var optionsView: UIPickerView {
        
        let optionsView = UIPickerView()
        optionsView.delegate = self
        optionsView.dataSource = self
        optionsView.selectRow(defaultMultipleChoiceIndex, inComponent: 0, animated: false)
        
        return optionsView
    }
    
    private var defaultMultipleChoiceIndex: Int {
        
        guard let formRow = formRow else {
            return 0
        }
        
        var selectedRow = 0
        if (formRow.values?.count > formRow.selectedValueIndex) && (formRow.selectedValueIndex > 0) {
            selectedRow = formRow.selectedValueIndex
        }
        
        return selectedRow
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let screenFrame = UIScreen.mainScreen().bounds
        let accessoryViewFrame = CGRect(x: 0, y: 0, width: screenFrame.size.width, height: 44.0)
        let accessoryView = FormRowAccessoryView(frame: accessoryViewFrame)
        accessoryView.inputDelegate = self
        textField?.inputAccessoryView = accessoryView
        
        selectionStyle = .None
        
        textField?.addTarget(self, action: #selector(FormRowCell.textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        
        if textField?.delegate == nil {
            textField?.delegate = self
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        
        guard editable else {
            return false
        }
        
        return textField?.becomeFirstResponder() ?? false
    }
    
    override func resignFirstResponder() -> Bool {
        endEditing(true)
        return textField?.resignFirstResponder() ?? false
    }
    
    func textFieldDidChange(textField: UITextField) {
        formRow?.value = textField.text
    }
}

extension FormRowCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formRow?.values?[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField?.text = formRow?.values![row]
        formRow?.selectedValueIndex = row
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formRow?.values?.count ?? 0
    }
}

extension FormRowCell: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        formRowAccessoryViewDidPressNextButton((textField.inputAccessoryView as? FormRowAccessoryView)!)
        return false
    }
}

extension FormRowCell: FormRowAccessoryViewDelegate {
    
    func formRowAccessoryViewDidPressPreviousButton(accessoryView: FormRowAccessoryView) {
        inputAccessoryDelegate?.formRowCellDidPressPreviousButton(self)
    }
    
    func formRowAccessoryViewDidPressNextButton(accessoryView: FormRowAccessoryView) {
        inputAccessoryDelegate?.formRowCellDidPressNextButton(self)
    }
    
    func formRowAccessoryViewDidPressDoneButton(accessoryView: FormRowAccessoryView) {
        inputAccessoryDelegate?.formRowCellDidPressDoneButton(self)
    }
}