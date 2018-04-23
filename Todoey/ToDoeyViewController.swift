//
//  ViewController.swift
//  Todoey
//
//  Created by Jun Miao on 18/04/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import UIKit

class ToDoeyViewController: UITableViewController {

    let itemArray = ["A", "B", "C"]
    var theChecked : Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    //MARK:-  datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        
        return itemArray.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
     //  tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark  // 很显然这个函数应该是tableview都已经形成后才能使用的。是在delegate使用的函数
        // 在datasource里 是正在建立这个cell 所以肯定要用dequeResuableCell 这个函数先建立cell

        

        
        return cell
        
    }
    
    //MARK:- delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        
      tableView.deselectRow(at: indexPath, animated: true)
        
     //   tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType(rawValue: 0)!
        
      
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }

      
      
    }


    

}

