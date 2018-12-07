//
//  SwiftTableViewExample.swift
//  SwiftScrollViewExample
//
//  Created by Rajamohan S, Independent Software Developer on 07/12/18.
//  Copyright (c) 2018 Rajamohan S. All rights reserved.
//
//	See https://rajamohan-s.github.io/ for author information.
//
 

import UIKit
import SwiftScrollViews

class SwiftCollectionViewExample: UIViewController,UICollectionViewDataSource,SwiftScrollViewsDelegate {

    @IBOutlet weak var collectionView: SwiftCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.swiftScrollViewsDelegate = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let textField = cell.viewWithTag(1) as! UITextField
        textField.placeholder = "Section \(indexPath.section) at Index \(indexPath.row)"
        textField.returnKeyType = indexPath.section == 0 && indexPath.row == 1 ? .search : indexPath.section == 1 && indexPath.row == 4 ? .go : .default
        return cell
        
    }
    
    func didEditingDone(for textField: UITextField) {
        
        let controller  = UIAlertController(title: textField.placeholder ?? "Place Holder Empty!", message: "✅ Editing Done!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "👍", style: .default, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
