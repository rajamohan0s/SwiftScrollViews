//
//  SwiftCollectionViewExample.swift
//  SwiftScrollViewExample
//
//  Created by Rajamohan S, Independent Software Developer on 07/12/18.
//  Copyright (c) 2018 Rajamohan S. All rights reserved.
//
//	See https://rajamohan-s.github.io/ for author information.
//
 

import UIKit
import SwiftScrollViews

class SwiftTableViewExample: UIViewController,UITableViewDataSource,SwiftScrollViewsDelegate {

    @IBOutlet weak var tableView: SwiftTableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.swiftScrollViewsDelegate  = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 2 : section == 1 ? 5 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        let textField = cell.viewWithTag(1) as! UITextField
        textField.placeholder = "Section \(indexPath.section) at Index \(indexPath.row)"
        textField.returnKeyType = indexPath.section == 0 && indexPath.row == 1 ? .search : indexPath.section == 1 && indexPath.row == 4 ? .go : .default
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return ["Login","Client Register","Admin Register"][section]
    }
    func didEditingDone(for textField: UITextField) {
        
        let controller  = UIAlertController(title: textField.placeholder ?? "Place Holder Empty!", message: "✅ Editing Done!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "👍", style: .default, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }

    

}
