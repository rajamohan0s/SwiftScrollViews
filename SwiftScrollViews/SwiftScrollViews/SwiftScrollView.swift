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
    

    @IBOutlet var swiftScrollViewsDelegate:SwiftScrollViewsDelegate?
    
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
    
    //MARK:- UITextField
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if self.swiftScrollViewsDelegate?.textFieldShouldReturn?(textField) != false{
            self.shouldReturn(for: textField, with: self.swiftScrollViewsDelegate)
            return true
        }
        return false
    }
    
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if self.swiftScrollViewsDelegate?.textFieldShouldBeginEditing?(textField) != false{
            self.shouldBegin(textField)
            return true
        }
        return false
    }

   
  
}
