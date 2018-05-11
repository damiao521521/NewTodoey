//
//  SuperClassSwipeTableViewController.swift
//  
//
//  Created by Jun Miao on 05/05/2018.
//

import UIKit
import SwipeCellKit
import RealmSwift

class SuperClassSwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate {

    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        //
        let mjDeleteActioninstance = SwipeAction(style: .destructive, title: "delete") { (deleteAction, indexPatha) in
            
            let mjAlert = UIAlertController(title: "title :Are you Sure to delete", message: "message:delte delete delete", preferredStyle: .actionSheet)
            
            mjAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
                self.mjDeleteAction(at: indexPatha)
                
                if self.tableView.numberOfRows(inSection: 0) == 1 {
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                    deleteAction.fulfill(with: .delete)
                    self.tableView.endUpdates()
                }else {
                        self.tableView.beginUpdates()
                    deleteAction.fulfill(with: .delete)
                           self.tableView.endUpdates()
                }
                
                
            }))
            
            mjAlert.addAction(UIAlertAction(title: "I don't want to delete", style: .cancel, handler: { (nothingAction) in
                
                print("nothing to do sir" )
                self.tableView.reloadData()
            }))
            
            self.present(mjAlert, animated: true, completion: nil)
            
         

            
            

        }
        
        mjDeleteActioninstance.image = UIImage(named: "delete-Icon")
        
        
        return [mjDeleteActioninstance]
        
    }
    

    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive(automaticallyDelete: false)
        options.transitionStyle = .border
        return options
    }
    
    
    func mjDeleteAction (at : IndexPath) {
        
    }
    
    func confirmToDelete ()  {
        
  
        
        let mjAlert = UIAlertController(title: "title :Are you Sure to delete", message: "message:delte delete delete", preferredStyle: .actionSheet)
        
        mjAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
   
            
            
        }))
        
        mjAlert.addAction(UIAlertAction(title: "I don't want to delete", style: .cancel, handler: { (nothingAction) in
            //
            print("nothing to do sir" )
        }))
        
        present(mjAlert, animated: true, completion: nil)
        
   
        
        
    }

}
