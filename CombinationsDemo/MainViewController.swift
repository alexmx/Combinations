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
        emailRow.rowType = .email
        passwordRow = FormRow(title: "Password", value: nil)
        passwordRow.rowType = .passcode
        genderRow = FormRow(title: "Gender", values: ["Male", "Female"])
        
        rows = [firstNameRow, emailRow, passwordRow, genderRow]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: FormViewControllerDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows?.count ?? 0
    }
    
    override func formViewController(_ controller: FormViewController, formRowForIndexPath indexPath: IndexPath) -> FormRow {
        return rows![(indexPath as NSIndexPath).row]
    }
    
    // MARK: Actions
    
    @IBAction func didPressValidate(_ sender: UIBarButtonItem) {
    
        print("Validate")
    }
}

