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
        let mjDeleteAction = SwipeAction(style: .destructive, title: "delete") { (deleteAction, indexPatha) in
            
            self.mjDeleteAction(at: indexPatha)
        }
        
        mjDeleteAction.image = UIImage(named: "delete-Icon")
        
        return [mjDeleteAction]
        
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    
    func mjDeleteAction (at : IndexPath) {
        
    }

}
