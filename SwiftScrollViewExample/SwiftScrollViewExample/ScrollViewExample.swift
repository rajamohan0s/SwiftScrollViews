//
//  ViewController.swift
//  SwiftScrollViewExample
//
//  Created by Rajamohan S, Independent Software Developer on 30/11/18.
//  Copyright (c) 2018 Rajamohan S. All rights reserved.
//
//  See https://rajamohan-s.github.io/ for author information.
//

import UIKit
import SwiftScrollViews

class ScrollViewExample: UIViewController,SwiftScrollViewDelegate {
   

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func didEditingDone(for textField: UITextField) {
        
        let controller  = UIAlertController(title: textField.placeholder ?? "Place Holder Nil", message: "✅ Editing Done!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "👍", style: .default, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }

}

