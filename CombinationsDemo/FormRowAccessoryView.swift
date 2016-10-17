//
//  FormRowAccessoryView.swift
//  Combinations
//
//  Created by Alexandru Maimescu on 6/20/16.
//  Copyright © 2016 Alexandru Maimescu. All rights reserved.
//

import UIKit

protocol FormRowAccessoryViewDelegate: UIToolbarDelegate {
    
    func formRowAccessoryViewDidPressPreviousButton(_ accessoryView: FormRowAccessoryView)
    func formRowAccessoryViewDidPressNextButton(_ accessoryView: FormRowAccessoryView)
    func formRowAccessoryViewDidPressDoneButton(_ accessoryView: FormRowAccessoryView)
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
    
    fileprivate func setup() {
        
        barStyle = .default
        isTranslucent = true
        
        let previousItem = UIBarButtonItem(image: UIImage(named: "icon-arrow-left"), style: .plain, target: self, action: #selector(FormRowAccessoryView.previousDidPress(_:)))
        let nextItem = UIBarButtonItem(image: UIImage(named: "icon-arrow-right"), style: .plain, target: self, action: #selector(FormRowAccessoryView.nextDidPress(_:)))
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(FormRowAccessoryView.doneDidPress(_:)))
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        items = [previousItem, nextItem, flexibleItem, doneItem]
        tintColor = UIColor.darkGray
    }
    
    func previousDidPress(_ item: UIBarButtonItem) {
        inputDelegate?.formRowAccessoryViewDidPressPreviousButton(self)
    }
    
    func nextDidPress(_ item: UIBarButtonItem) {
        inputDelegate?.formRowAccessoryViewDidPressNextButton(self)
    }
    
    func doneDidPress(_ item: UIBarButtonItem) {
        inputDelegate?.formRowAccessoryViewDidPressDoneButton(self)
    }
}
