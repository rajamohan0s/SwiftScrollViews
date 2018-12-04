//
//  SwiftCollectionView.swift
//  SwiftScrollView
//
//  Created by Rajamohan S, Independent Software Developer on 01/12/18.
//  Copyright (c) 2018 Rajamohan S. All rights reserved.
//
//  See https://rajamohan-s.github.io/ for author information.
//

import UIKit

open class SwiftCollectionView:UITableView,TextComponentDelegate{
  
    private var textComponents = [UIView]()
    open var swiftScrollViewDelegate:SwiftScrollViewDelegate?
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.addNotifications()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addNotifications()
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegateTextComponents(in: self, textComponents: &textComponents)
    }
   
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.shouldReturn(for: textField, with: self.swiftScrollViewDelegate)
        
    }
    
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return self.shouldBegin(textField)
    }
}
