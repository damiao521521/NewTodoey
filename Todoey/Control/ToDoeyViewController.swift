//
//  ViewController.swift
//  Todoey
//
//  Created by Jun Miao on 18/04/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class ToDoeyViewController: UITableViewController, UISearchBarDelegate {

    
    var selectedCategory : MJCategory?  {
        didSet  {
            load()
        }
    }
    let mjRealm = try! Realm()
    var itemArray : Results<MJItem>?


    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPressedGesture.minimumPressDuration = 1
        self.view.addGestureRecognizer(longPressedGesture)
        
        load()
 

        

        
        
    }


    //MARK:-  datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        
        return itemArray?.count ?? 1
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = itemArray?[indexPath.row].toDoTitle ?? "no item sir"
        
        if let tempArray = itemArray {
             cell.accessoryType = tempArray[indexPath.row].toDoCheck ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        }
       

        cell.backgroundColor = UIColor.blue


        return cell
        
    }
    
    //MARK:- delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item =  itemArray {
            do {
                try  mjRealm.write {
                    
                  //  item[indexPath.row].toDoCheck = !item[indexPath.row].toDoCheck
                    
                    mjRealm.delete(item[indexPath.row])
                    
                }
            }catch {
                print(error)
            }
        }
        
    

        
    //    itemArray![indexPath.row].toDoCheck = !itemArray![indexPath.row].toDoCheck
        
      //  save()
        


    tableView.reloadData()
        


      
      
    }

    //MARK:- barButton pressed
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        

        
        let mjAlert = UIAlertController(title: "Title :PLS add new Item Sir", message: "get some new item message ", preferredStyle: .alert)
        
        mjAlert.addAction(UIAlertAction(title: "very good", style: .default, handler: { (yourAction) in
            
                       let tempItem = MJItem()
            
            tempItem.toDoTitle = mjAlert.textFields![0].text!
            tempItem.toDoCheck = false
            
            if let tempCategory = self.selectedCategory {
                
                do {
                   
                    try self.mjRealm.write {
                            tempCategory.mjItems.append(tempItem)
                    }
                }catch {
                    print(error)
                }
                
                
                
            }
            
            
      
            
           // self.add(item: tempItem)
           

            
            self.tableView.reloadData()

            
        }))
        mjAlert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        mjAlert.addTextField { (yourInput) in
            

        }
        mjAlert.addTextField { (secondInput) in
            //
        }
        
        
        present(mjAlert, animated: true, completion: nil)
        
    }
    
    //MARK: - load and save data
    
    func add (item: MJItem) {
        
        
        do {
            

            try   mjRealm.write {
                mjRealm.add(item)
            }
        }catch {
            print (error)
        }
        
    
    }
    
    
    func load () {
        
        
   //  itemArray =   mjRealm.objects(MJItem.self)
        
        itemArray = selectedCategory?.mjItems.sorted(byKeyPath: "toDoTitle", ascending: true)

   
        tableView.reloadData()
    }
    
    
    //MARK: - SearchBar related delegate methodextension Double {

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        itemArray = itemArray?.filter("toDoTitle CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "toDoTitle", ascending: true)
        
        tableView.reloadData()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            load()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }        }
        else {
            itemArray = itemArray?.filter("toDoTitle CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "toDoTitle", ascending: true)
            
            tableView.reloadData()
        }

        
    }
    
    

}

