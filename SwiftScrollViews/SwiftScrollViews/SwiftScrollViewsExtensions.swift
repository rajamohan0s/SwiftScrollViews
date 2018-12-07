//
//  Extension+UIScrollView.swift
//  SwiftScrollView
//
//  Created by Rajamohan S, Independent Software Developer on 30/11/18.
//  Copyright (c) 2018 Rajamohan S. All rights reserved.
//
//  See https://rajamohan-s.github.io/ for author information.
//

import UIKit

//MARK:- Keyboard Size
fileprivate var keyboardHeight:CGFloat = 0

//MARK:- Variable for kAssociationKeyNextField
private var kAssociationKeyNextField: UInt8 = 0

//MARK:- TextComponentDelegate
internal typealias TextComponentDelegate = UITextFieldDelegate & UITextViewDelegate

//MARK:- Protocol of SwiftScrollViewExtension
internal protocol SwiftScrollViewExtension{}

//MARK:- Extension of SwiftScrollViewExtension
internal extension SwiftScrollViewExtension where Self:UIScrollView{
    
    private func keyboardSize(from notification:Notification)->CGRect?{
        
        return (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
    
   fileprivate var notification: NotificationCenter { return NotificationCenter.default }
    
   fileprivate var isSwiftScrollView:Bool{ return self is SwiftScrollView || self is SwiftTableView || self is SwiftCollectionView }
   
    //Observe keyboard notifications
   internal func addNotifications(){
        
    self.notification.addObserver(forName:  UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
            self.observeKeyboard(notification, isShow:true)
        }
        
    self.notification.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
            self.observeKeyboard(notification, isShow:false)
        }
    }
    
    
    //Remove observers of keyboard notifications
    fileprivate func removeNotifications(){
        
        self.notification.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        self.notification.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Keyboard Show & Hide notifications
    private func observeKeyboard(_ notification:Notification,isShow:Bool){
    
        guard let keyboardSize =  self.keyboardSize(from: notification) else{
            return
        }

        if isShow{
            let tabBarHeight = self.viewController?.tabBarController?.tabBar.frame.size.height ?? 0
            self.contentInset.bottom = (keyboardSize.height+SwiftScrollViews.config.textComponentSpaceFromKeyboard)-tabBarHeight
            keyboardHeight  = keyboardSize.height
            self.scrollIndicatorInsets = contentInset
        }else{
            self.contentInset.bottom = 0
            self.scrollIndicatorInsets = .zero
        }
    }
    
    //Setting UITextFieldDelegate & UITextViewDelegate
    internal func delegateTextComponents(in rootView:UIView,textComponents:inout [UIView]){
        
        rootView.subviews.forEach { (view) in
            
            if view.isTextComponent{
                
                if !textComponents.contains(view){
                    textComponents.append(view)
                }
                
                if let textField = view.textField{
                    if textField.delegate == nil{
                        self.setDelegate(for: textField)
                    }
                    
                }else if let textView = view.textView{
                    if textView.delegate == nil{
                        self.setDelegate(for: textView)
                    }
                }
            }else{
                self.delegateTextComponents(in: view, textComponents: &textComponents)
            }
        }
        
        textComponents.sorted()
        
        textComponents.enumerated().forEach { (index,view) in
            
            if textComponents.count-1 > index{
                let nextView = textComponents[index+1]
                view.textComponent  = nextView
            }
        }
    }
    
    internal func setDelegate(for textField:UITextField){
        
        if let scrollView = self as? SwiftScrollView{
            textField.delegate = scrollView
        }else if let tableView = self as? SwiftTableView{
            
            textField.delegate = tableView
        }else{
            let collectionView = self as? SwiftCollectionView
            textField.delegate = collectionView
        }
    }
    
    internal func setDelegate(for textView:UITextView){
        
        if let scrollView = self as? SwiftScrollView{
            textView.delegate = scrollView
        }else if let tableView = self as? SwiftTableView{
            textView.delegate = tableView
        }else{
            let collectionView = self as? SwiftCollectionView
            textView.delegate = collectionView
        }
    }
    
    internal func shouldBegin(_ textField: UITextField) -> Bool{
        
        textField.returnKeyType = textField.nextTextComponent == nil ? textField.returnKeyType == .default ? SwiftScrollViews.config.defaultDoneKey : textField.returnKeyType : textField.returnKeyType == .default ? .next : textField.returnKeyType
        
        return true
    }
    
    internal func shouldReturn(for textField: UITextField,with delegate:SwiftScrollViewsDelegate?) -> Bool{
        
        if let nextComponent = textField.nextTextComponent,textField.returnKeyType == .next{
            nextComponent.becomeFirstResponder()
            
            if nextComponent is UITextView{
                self.setContentForTextComponent()
            }
        }else{
            
            textField.resignFirstResponder()
            delegate?.didEditingDone(for: textField)
            
        }
        return true
    }
    
    private func setContentForTextComponent(){
        
        if let nextComponent = self.firstResponder{
            let point = nextComponent.superview!.convert(nextComponent.frame, to: nextComponent.window!).origin
            
            var fontSize:CGFloat = 0
            
            if let textField = nextComponent.textField{
                
                fontSize = textField.font?.pointSize ?? 0
            }else if let textView = nextComponent.textView{
                
                fontSize = textView.font?.pointSize ?? 0
            }
            
            let visibleHeight  = self.viewController!.view.frame.height-keyboardHeight-fontSize
            
            if (point.y+fontSize) >= visibleHeight{
                
                self.setContentOffset(CGPoint(x: self.contentOffset.x, y: self.contentOffset.y+fontSize+SwiftScrollViews.config.textComponentSpaceFromKeyboard), animated: true)
            }
        }
    }
}

//MARK:- Extension of UIScrollView
extension UIScrollView:SwiftScrollViewExtension{

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if self.isSwiftScrollView{
           
            if self.isKeyboardPresented{
                self.firstResponder?.resignFirstResponder()
            }
        }
    }
    
    override open func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)

        if self.isSwiftScrollView && newWindow == nil{
            self.removeNotifications()
        }
    }
}


//MARK:- Extension of UIView
fileprivate extension UIView{
    
    
    //UITextField & UITextView
    var isTextComponent:Bool{
        
        return self is UITextField || self is UITextView
    }
    
    var textField:UITextField?{ return self as? UITextField }
    
    var textView:UITextView?{ return self as? UITextView }
    
    var firstResponder:UIView?{
        
        if self.isFirstResponder{
            return self
        }
        
        for view in self.subviews{
            
            if view.isFirstResponder{
                return view
            }
            
            if let firstResponder =  view.firstResponder{
                
                return firstResponder
            }
        }
        
        return nil
    }
    
    var textComponent: UIView? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UIView
        }
        set(newTextComponent) {
            
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newTextComponent, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var nextTextComponent:UIView?{
        
        if let nextComponent = self.textComponent{
            
            if !nextComponent.isHidden && nextComponent.isUserInteractionEnabled {
                return nextComponent
            }else{
                return nextComponent.nextTextComponent
            }
        }
        return nil
    }
    
    //UIKeyboard
    var isKeyboardPresented: Bool {
        
        for window in UIApplication.shared.windows{
            
            let className = NSStringFromClass(window.classForCoder)
            if className == "UIRemoteKeyboardWindow"{
                return true
            }
        }
        return false
    }
    
    //Parent view controller of a view
    var viewController: UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder!.next
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

//Shorting by origin
fileprivate extension Array where Element == UIView{
    
    mutating func sorted(){
        self.sort { (v1, v2) -> Bool in
            if v1.window != nil && v2.window != nil{
                if let p1 = v1.superview?.convert(v1.frame, to: v1.window!).origin{
                    if let p2 = v2.superview?.convert(v2.frame, to: v2.window!).origin{
                
                        return (p1.x < p2.x && p1.y == p2.y) || p1.y < p2.y
                    }
                }
            }
            return false
        }
    }
}
