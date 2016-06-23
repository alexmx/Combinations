//
//  Utils.swift
//  Combinations
//
//  Created by Alexandru Maimescu on 6/23/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func tapElementAndWaitForKeyboardToAppear(element: XCUIElement) {
        let keyboard = XCUIApplication().keyboards.element
        while (true) {
            element.tap()
            if keyboard.exists {
                break;
            }
            NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.5))
        }
    }
}