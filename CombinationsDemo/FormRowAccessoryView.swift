//
//  FormRowAccessoryView.swift
//  Combinations
//
//  Created by Alexandru Maimescu on 6/20/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import UIKit

protocol FormRowAccessoryViewDelegate: UIToolbarDelegate {
    
    func formRowAccessoryViewDidPressPreviousButton(accessoryView: FormRowAccessoryView)
    func formRowAccessoryViewDidPressNextButton(accessoryView: FormRowAccessoryView)
    func formRowAccessoryViewDidPressDoneButton(accessoryView: FormRowAccessoryView)
}


class FormRowAccessoryView: UIToolbar {
    
    weak var inputDelegate: FormRowAccessoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        
        barStyle = .Default
        translucent = true
        
        let previousItem = UIBarButtonItem(image: UIImage(named: "icon-arrow-left"), style: .Plain, target: self, action: #selector(FormRowAccessoryView.previousDidPress(_:)))
        let nextItem = UIBarButtonItem(image: UIImage(named: "icon-arrow-right"), style: .Plain, target: self, action: #selector(FormRowAccessoryView.nextDidPress(_:)))
        let doneItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(FormRowAccessoryView.doneDidPress(_:)))
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        items = [previousItem, nextItem, flexibleItem, doneItem]
        tintColor = UIColor.darkGrayColor()
    }
    
    func previousDidPress(item: UIBarButtonItem) {
        inputDelegate?.formRowAccessoryViewDidPressPreviousButton(self)
    }
    
    func nextDidPress(item: UIBarButtonItem) {
        inputDelegate?.formRowAccessoryViewDidPressNextButton(self)
    }
    
    func doneDidPress(item: UIBarButtonItem) {
        inputDelegate?.formRowAccessoryViewDidPressDoneButton(self)
    }
}