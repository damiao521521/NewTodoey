//
//  longPressed.swift
//  Todoey
//
//  Created by Jun Miao on 29/04/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import Foundation
import UIKit



extension ToDoeyViewController {
    
    
    @objc  func longPressed (sender : UILongPressGestureRecognizer) {

            
  
        if sender.state == UIGestureRecognizerState.began {
            
            let touchPoint = sender.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                print("Long pressed row: \(indexPath.row)")
                
                let A = UIAlertController(title: "you want to modify", message: "message modify", preferredStyle: .alert)
                
                A.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                    
                    if let tempItem = self.itemArray?[indexPath.row] {
                        do {
                            try    self.mjRealm.write {
                                tempItem.toDoTitle =  A.textFields![0].text!
                            }
                        } catch {
                            print(error)
                        }
                    }
                 
              
                    
                
           
                    self.tableView.reloadData()
                    
                    
                }))
                
                A.addTextField(configurationHandler: { (textfiled) in
                    
                })
                
                present(A, animated: true, completion: nil)
                
            }
        }
        
        
    
}
}
