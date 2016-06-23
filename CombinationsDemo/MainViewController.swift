//
//  MainViewController.swift
//  CombinationsDemo
//
//  Created by Alexandru Maimescu on 6/20/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import UIKit

class MainViewController: FormViewController {

    var rows: [FormRow]?
    
    var firstNameRow: FormRow!,
        emailRow: FormRow!,
        passwordRow: FormRow!,
        genderRow: FormRow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        tableView.tableFooterView = UIView()
        
        loadData()
    }

    func loadData() {
        
        firstNameRow = FormRow(title: "First Name", value: nil)
        emailRow = FormRow(title: "Email", value: nil)
        emailRow.rowType = .Email
        passwordRow = FormRow(title: "Password", value: nil)
        passwordRow.rowType = .Passcode
        genderRow = FormRow(title: "Gender", values: ["Male", "Female"])
        
        rows = [firstNameRow, emailRow, passwordRow, genderRow]
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: FormViewControllerDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows?.count ?? 0
    }
    
    override func formViewController(controller: FormViewController, formRowForIndexPath indexPath: NSIndexPath) -> FormRow {
        return rows![indexPath.row]
    }
    
    // MARK: Actions
    
    @IBAction func didPressValidate(sender: UIBarButtonItem) {
    
        print("Validate")
    }
}

