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
    
    func formViewController(controller: FormViewController, formRowForIndexPath indexPath: NSIndexPath) -> FormRow
    
    func formViewController(controller: FormViewController, classForFormRowCellAtIndexPath indexPath: NSIndexPath) -> AnyClass?
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if autoEnableEditing == true {
            // Enable editing for first row in form
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))?.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        tableView.endEditing(true)
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellClass: AnyClass? = dataSource?.formViewController(self, classForFormRowCellAtIndexPath: indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(String(cellClass!))
        
        let sectionsCount = tableView.numberOfSections
        let rowsCountInSection = tableView.numberOfRowsInSection(indexPath.section)
        
        if cell!.isKindOfClass(FormRowCell.self) {
            let formRowCell = cell as? FormRowCell
            
            if (indexPath.section == sectionsCount - 1) &&
                (indexPath.row == rowsCountInSection - 1) {
                formRowCell?.textField?.returnKeyType = .Default
            } else {
                formRowCell?.textField?.returnKeyType = .Next
            }
            
            let formRow = dataSource?.formViewController(self, formRowForIndexPath: indexPath)
            formRowCell?.formRow = formRow
            formRowCell?.inputAccessoryDelegate = self
        }
        
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.isKindOfClass(FormRowCell.self) {
                cell.becomeFirstResponder()
            }
        }
    }
    
    // MARK: Rows Navigation
    
    private func nextIndexPath(indexPath: NSIndexPath) -> NSIndexPath? {
        
        let numberOfSections = tableView.numberOfSections
        let numberOfRowsInSection = tableView.numberOfRowsInSection(indexPath.section)
        
        if (indexPath.section < numberOfSections - 1) || (indexPath.row < numberOfRowsInSection - 1) {
            
            if indexPath.row + 1 == numberOfRowsInSection {
                return NSIndexPath(forRow: 0, inSection: indexPath.section + 1)
            } else {
                return NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
            }
        }
        
        return nil
    }
    
    private func previousIndexPath(indexPath: NSIndexPath) -> NSIndexPath? {
        
        if !(indexPath.row == 0 && indexPath.section == 0) {
            
            if indexPath.row > 0 {
                return NSIndexPath(forRow: indexPath.row - 1, inSection: indexPath.section)
            } else {
                let previousSection = indexPath.section - 1
                let numberOfRowsInPreviousSection = tableView.numberOfRowsInSection(previousSection)
                return NSIndexPath(forRow: numberOfRowsInPreviousSection - 1, inSection: previousSection)
            }
        }
        
        return nil
    }
    
    // MARK: FormViewControllerDataSource
    
    func formViewController(controller: FormViewController, classForFormRowCellAtIndexPath indexPath: NSIndexPath) -> AnyClass? {
        return FormRowCell.self
    }
    
    func formViewController(controller: FormViewController, formRowForIndexPath indexPath: NSIndexPath) -> FormRow {
        return FormRow() // Provide empty row
    }
}


extension FormViewController: FormRowCellInputAccessoryDelegate {
    
    // MARK: FormRowCellInputAccessoryDelegate
    
    final func formRowCellDidPressPreviousButton(cell: FormRowCell) {
        
        let indexPath = tableView.indexPathForCell(cell)
        let previousIndexPath = self.previousIndexPath(indexPath!)
        
        if let previousIndexPath = previousIndexPath {
            let previousCell = tableView.cellForRowAtIndexPath(previousIndexPath) as? FormRowCell
            if previousCell?.becomeFirstResponder() == false {
                cell.resignFirstResponder()
            }
        }
    }
    
    final func formRowCellDidPressNextButton(cell: FormRowCell) {
        
        let indexPath = tableView.indexPathForCell(cell)
        let nextIndexPath = self.nextIndexPath(indexPath!)
        
        if let nextIndexPath = nextIndexPath {
            let nextCell = tableView.cellForRowAtIndexPath(nextIndexPath) as? FormRowCell
            if nextCell?.becomeFirstResponder() == false {
                cell.resignFirstResponder()
            }
        } else {
            cell.resignFirstResponder()
        }
    }
    
    final func formRowCellDidPressDoneButton(cell: FormRowCell) {
        cell.resignFirstResponder()
    }
}