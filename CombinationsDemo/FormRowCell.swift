//
//  FormRowCell.swift
//  Combinations
//
//  Created by Alexandru Maimescu on 6/20/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import UIKit

protocol FormRowCellInputAccessoryDelegate: class {
    
    func formRowCellDidPressPreviousButton(_ cell: FormRowCell)
    func formRowCellDidPressNextButton(_ cell: FormRowCell)
    func formRowCellDidPressDoneButton(_ cell: FormRowCell)
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
                case .passcode:
                    textField.isSecureTextEntry = true
                case .multipleChoice:
                    textField.inputView = optionsView
                    textField.text = formRow.values?[defaultMultipleChoiceIndex]
                case .email:
                    textField.autocapitalizationType = .none
                    textField.keyboardType = .emailAddress
                default:
                    textField.keyboardType = .default
                }
            }
        }
    }
    
    var editable: Bool = true {
        
        didSet {
            textField?.isEnabled = editable
        }
    }
    
    fileprivate var optionsView: UIPickerView {
        
        let optionsView = UIPickerView()
        optionsView.delegate = self
        optionsView.dataSource = self
        optionsView.selectRow(defaultMultipleChoiceIndex, inComponent: 0, animated: false)
        
        return optionsView
    }
    
    fileprivate var defaultMultipleChoiceIndex: Int {
        
        guard let formRow = formRow else {
            return 0
        }
        
        var selectedRow = 0
        if ((formRow.values?.count)! > formRow.selectedValueIndex) && (formRow.selectedValueIndex > 0) {
            selectedRow = formRow.selectedValueIndex
        }
        
        return selectedRow
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let screenFrame = UIScreen.main.bounds
        let accessoryViewFrame = CGRect(x: 0, y: 0, width: screenFrame.size.width, height: 44.0)
        let accessoryView = FormRowAccessoryView(frame: accessoryViewFrame)
        accessoryView.inputDelegate = self
        textField?.inputAccessoryView = accessoryView
        
        selectionStyle = .none
        
        textField?.addTarget(self, action: #selector(FormRowCell.textFieldDidChange(_:)), for: .editingChanged)
        
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
    
    func textFieldDidChange(_ textField: UITextField) {
        formRow?.value = textField.text
    }
}

extension FormRowCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formRow?.values?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField?.text = formRow?.values![row]
        formRow?.selectedValueIndex = row
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formRow?.values?.count ?? 0
    }
}

extension FormRowCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        formRowAccessoryViewDidPressNextButton((textField.inputAccessoryView as? FormRowAccessoryView)!)
        return false
    }
}

extension FormRowCell: FormRowAccessoryViewDelegate {
    
    func formRowAccessoryViewDidPressPreviousButton(_ accessoryView: FormRowAccessoryView) {
        inputAccessoryDelegate?.formRowCellDidPressPreviousButton(self)
    }
    
    func formRowAccessoryViewDidPressNextButton(_ accessoryView: FormRowAccessoryView) {
        inputAccessoryDelegate?.formRowCellDidPressNextButton(self)
    }
    
    func formRowAccessoryViewDidPressDoneButton(_ accessoryView: FormRowAccessoryView) {
        inputAccessoryDelegate?.formRowCellDidPressDoneButton(self)
    }
}
