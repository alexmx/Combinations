//
//  MainViewController.swift
//  CombinationsDemo
//
//  Created by Alexandru Maimescu on 6/20/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import UIKit

class MainViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        tableView.tableFooterView = UIView()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: FormViewControllerDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func formViewController(controller: FormViewController, formRowForIndexPath indexPath: NSIndexPath) -> FormRow {
        return FormRow(title: "Title", value: "Value")
    }
    
    // MARK: Actions
    
    @IBAction func didPressValidate(sender: UIBarButtonItem) {
        
      print("Validate")
    }
}

