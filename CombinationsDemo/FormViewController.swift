//
//  FormViewController.swift
//  Combinations
//
//  Created by Alexandru Maimescu on 6/20/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import UIKit

/// Form editing view controller data source
protocol FormViewControllerDataSource: class {
    
    func formViewController(_ controller: FormViewController, formRowForIndexPath indexPath: IndexPath) -> FormRow
    
    func formViewController(_ controller: FormViewController, classForFormRowCellAtIndexPath indexPath: IndexPath) -> AnyClass?
}

/// Form editing view controller
class FormViewController: UITableViewController, FormViewControllerDataSource {
    
    weak var dataSource: FormViewControllerDataSource?
    
    /// Auto enable editing for first row on appear
    var autoEnableEditing: Bool = false
    
    // MARK: VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set dynamic rows heigh (cell baces sizing)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if autoEnableEditing == true {
            // Enable editing for first row in form
            tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.endEditing(true)
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellClass: AnyClass? = dataSource?.formViewController(self, classForFormRowCellAtIndexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: cellClass!))
        
        let sectionsCount = tableView.numberOfSections
        let rowsCountInSection = tableView.numberOfRows(inSection: (indexPath as NSIndexPath).section)
        
        if cell!.isKind(of: FormRowCell.self) {
            let formRowCell = cell as? FormRowCell
            
            if ((indexPath as NSIndexPath).section == sectionsCount - 1) &&
                ((indexPath as NSIndexPath).row == rowsCountInSection - 1) {
                formRowCell?.textField?.returnKeyType = .default
            } else {
                formRowCell?.textField?.returnKeyType = .next
            }
            
            let formRow = dataSource?.formViewController(self, formRowForIndexPath: indexPath)
            formRowCell?.formRow = formRow
            formRowCell?.inputAccessoryDelegate = self
        }
        
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.isKind(of: FormRowCell.self) {
                cell.becomeFirstResponder()
            }
        }
    }
    
    // MARK: Rows Navigation
    
    fileprivate func nextIndexPath(_ indexPath: IndexPath) -> IndexPath? {
        
        let numberOfSections = tableView.numberOfSections
        let numberOfRowsInSection = tableView.numberOfRows(inSection: (indexPath as NSIndexPath).section)
        
        if ((indexPath as NSIndexPath).section < numberOfSections - 1) || ((indexPath as NSIndexPath).row < numberOfRowsInSection - 1) {
            
            if (indexPath as NSIndexPath).row + 1 == numberOfRowsInSection {
                return IndexPath(row: 0, section: (indexPath as NSIndexPath).section + 1)
            } else {
                return IndexPath(row: (indexPath as NSIndexPath).row + 1, section: (indexPath as NSIndexPath).section)
            }
        }
        
        return nil
    }
    
    fileprivate func previousIndexPath(_ indexPath: IndexPath) -> IndexPath? {
        
        if !((indexPath as NSIndexPath).row == 0 && (indexPath as NSIndexPath).section == 0) {
            
            if (indexPath as NSIndexPath).row > 0 {
                return IndexPath(row: (indexPath as NSIndexPath).row - 1, section: (indexPath as NSIndexPath).section)
            } else {
                let previousSection = (indexPath as NSIndexPath).section - 1
                let numberOfRowsInPreviousSection = tableView.numberOfRows(inSection: previousSection)
                return IndexPath(row: numberOfRowsInPreviousSection - 1, section: previousSection)
            }
        }
        
        return nil
    }
    
    // MARK: FormViewControllerDataSource
    
    func formViewController(_ controller: FormViewController, classForFormRowCellAtIndexPath indexPath: IndexPath) -> AnyClass? {
        return FormRowCell.self
    }
    
    func formViewController(_ controller: FormViewController, formRowForIndexPath indexPath: IndexPath) -> FormRow {
        return FormRow() // Provide empty row
    }
}

extension FormViewController: FormRowCellInputAccessoryDelegate {
    
    // MARK: FormRowCellInputAccessoryDelegate
    
    final func formRowCellDidPressPreviousButton(_ cell: FormRowCell) {
        
        let indexPath = tableView.indexPath(for: cell)
        let previousIndexPath = self.previousIndexPath(indexPath!)
        
        if let previousIndexPath = previousIndexPath {
            let previousCell = tableView.cellForRow(at: previousIndexPath) as? FormRowCell
            if previousCell?.becomeFirstResponder() == false {
                _ = cell.resignFirstResponder()
            }
        }
    }
    
    final func formRowCellDidPressNextButton(_ cell: FormRowCell) {
        
        let indexPath = tableView.indexPath(for: cell)
        let nextIndexPath = self.nextIndexPath(indexPath!)
        
        if let nextIndexPath = nextIndexPath {
            let nextCell = tableView.cellForRow(at: nextIndexPath) as? FormRowCell
            if nextCell?.becomeFirstResponder() == false {
                _ = cell.resignFirstResponder()
            }
        } else {
            _ = cell.resignFirstResponder()
        }
    }
    
    final func formRowCellDidPressDoneButton(_ cell: FormRowCell) {
        _ = cell.resignFirstResponder()
    }
}
