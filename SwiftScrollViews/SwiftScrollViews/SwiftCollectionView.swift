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

open class SwiftCollectionView:UICollectionView,TextComponentDelegate{
  
    private var textComponents = [UIView]()
    
    @IBOutlet public var swiftScrollViewsDelegate:SwiftScrollViewsDelegate?
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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
