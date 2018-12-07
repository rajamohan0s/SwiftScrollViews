//
//  SwiftTableView.swift
//  SwiftScrollView
//
//  Created by Rajamohan S, Independent Software Developer on 01/12/18.
//  Copyright (c) 2018 Rajamohan S. All rights reserved.
//
//  See https://rajamohan-s.github.io/ for author information.
//

import UIKit

open class SwiftTableView:UITableView,TextComponentDelegate{
    
    private var textComponents = [UIView]()
    
    @IBOutlet public var swiftScrollViewsDelegate:SwiftScrollViewsDelegate?
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.keyboardDismissMode = .onDrag
        self.addNotifications()

    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.keyboardDismissMode = .onDrag
        self.addNotifications()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.delegateTextComponents(in: self, textComponents: &textComponents)
    }
   
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.shouldReturn(for: textField, with: self.swiftScrollViewsDelegate)
    }
    
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return self.shouldBegin(textField)
    }
}
