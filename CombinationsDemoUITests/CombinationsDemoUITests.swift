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
    
    override func tearDown() {
        super.tearDown()
    }
    
    override class func inputValuesForCombinations() -> Matrix {
        
        return [
            ["John Smith", ""],
            ["john.smith@example.com", "john.smith@", ""],
            ["12345", ""],
            ["Male", "Female"]
        ]
    }
    
    override func assertCombination(combination: [AnyObject]) {
        
        if let firstName = combination[0] as? String,
            let email = combination[1] as? String,
            let password = combination[2] as? String,
            let gender = combination[3] as? String {
            
            let app = XCUIApplication()
            let tablesQuery = app.tables
            let firstNameCellsQuery = tablesQuery.cells.containingType(.StaticText, identifier:"First Name")
            tapElementAndWaitForKeyboardToAppear(firstNameCellsQuery.childrenMatchingType(.TextField).element)
            firstNameCellsQuery.childrenMatchingType(.TextField).element.typeText(firstName)
            let toolbarsQuery = app.toolbars
            let iconArrowRightButton = toolbarsQuery.buttons["icon arrow right"]
            iconArrowRightButton.tap()
            tablesQuery.cells.containingType(.StaticText, identifier:"Email").childrenMatchingType(.TextField).element.typeText(email)
            iconArrowRightButton.tap()
            tablesQuery.cells.containingType(.StaticText, identifier:"Password").childrenMatchingType(.SecureTextField).element.typeText(password)
            iconArrowRightButton.tap()
            app.pickerWheels.element.adjustToPickerWheelValue(gender)
            app.navigationBars["Demo"].buttons["Submit"].tap()
        } else {
            XCTFail()
        }
    }
}
