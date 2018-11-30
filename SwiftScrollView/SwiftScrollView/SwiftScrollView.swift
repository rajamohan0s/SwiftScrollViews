//
//  SwiftScrollView.swift
//  SwiftScrollView
//
//  Created by Apple on 30/11/18.
//  Copyright © 2018 Rajamohan-S. All rights reserved.
//

import UIKit

open class SwiftScrollView:UIScrollView,UITextFieldDelegate,UITextViewDelegate{
    
    private var notification = NotificationCenter.default
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {

        self.notification.removeObserver(self)
    }
}
