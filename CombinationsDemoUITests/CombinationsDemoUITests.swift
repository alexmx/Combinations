//
//  CombinationsDemoUITests.swift
//  CombinationsDemoUITests
//
//  Created by Alexandru Maimescu on 6/20/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import Combinations

class CombinationsDemoUITests: CombinationsSpec {
    
    override func setUp() {
        super.setUp()
        
        XCUIApplication().launch()
    }
    
    override class func valuesForCombinations() -> [[Any]]? {
        
        return [
            ["John Smith", ""],
            ["john.smith@example.com", "john.smith@", ""],
            ["12345", ""],
            ["Male", "Female"]
        ]
    }
    
    override func assertCombination(_ combination: [Any]) {
    
        if let combination = combination as? [String] {
            
            let firstName = combination[0]
            let email = combination[1]
            let password = combination[2]
            let gender = combination[3]
            
            let app = XCUIApplication()
            let tablesQuery = app.tables
            let firstNameCellsQuery = tablesQuery.cells.containing(.staticText, identifier:"First Name")
            tapElementAndWaitForKeyboardToAppear(firstNameCellsQuery.children(matching: .textField).element)
            firstNameCellsQuery.children(matching: .textField).element.typeText(firstName)
            let toolbarsQuery = app.toolbars
            let iconArrowRightButton = toolbarsQuery.buttons["icon arrow right"]
            iconArrowRightButton.tap()
            tablesQuery.cells.containing(.staticText, identifier:"Email").children(matching: .textField).element.typeText(email)
            iconArrowRightButton.tap()
            tablesQuery.cells.containing(.staticText, identifier:"Password").children(matching: .secureTextField).element.typeText(password)
            iconArrowRightButton.tap()
            app.pickerWheels.element.adjust(toPickerWheelValue: gender)
            app.navigationBars["Demo"].buttons["Submit"].tap()
            
            // Perform required asserts
            
        } else {
            XCTFail()
        }
    }
}
