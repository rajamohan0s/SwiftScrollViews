//
//  SwiftScrollView.swift
//  SwiftScrollView
//
//  Created by Rajamohan S, Independent Software Developer on 30/11/18.
//  Copyright (c) 2018 Rajamohan S. All rights reserved.
//
//  See https://rajamohan-s.github.io/ for author information.
//

import UIKit

open class SwiftScrollView:UIScrollView,TextComponentDelegate{
    

    @IBOutlet public var swiftScrollViewsDelegate:SwiftScrollViewsDelegate?
    
    private var identifier:String{
        
        return self.restorationIdentifier ?? "Nil"
    }
    
    private var textComponents = [UIView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
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
        return self.shouldReturn(for: textField, with: self.swiftScrollViewsDelegate)
    }
    
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return self.shouldBegin(textField)
    }
  
}
