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
import ChameleonFramework

class ToDoeyViewController: SuperClassSwipeTableViewController, UISearchBarDelegate {

    
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
        
     //   load()

        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.barTintColor = UIColor.flatMint
         navigationController?.navigationBar.tintColor = UIColor.flatRed
    }
    

    //MARK:-  datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        
        return itemArray?.count ?? 1
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
     //   let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = itemArray?[indexPath.row].toDoTitle ?? "no item sir"
        


        
        let myCGFloat = CGFloat( indexPath.row ) / CGFloat(tableView.numberOfRows(inSection: 0) )
        
        
        
        if let tempColorString = selectedCategory?.cellColor {
            
       
          cell.backgroundColor = UIColor(hexString: tempColorString)?.darken(byPercentage: myCGFloat)
            cell.textLabel?.textColor = ContrastColorOf((UIColor(hexString: tempColorString)?.darken(byPercentage: myCGFloat))!, returnFlat: true)
            
        }
        
            
        
        
        if let tempArray = itemArray {
             cell.accessoryType = tempArray[indexPath.row].toDoCheck ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        }
       

  


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
            tempItem.toDoTime = Date()
            
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
            yourInput.addTarget(self, action: #selector(self.alertTextFieldChanged), for: .editingChanged)

        }
        mjAlert.addTextField { (secondInput) in
            //
        }
       
         mjAlert.actions[1].isEnabled = false
        present(mjAlert, animated: true, completion: nil)
        
    }
    
    @objc func alertTextFieldChanged(_ sender: Any) {
        let alertTextField = sender as! UITextField
        var responder: UIResponder! = alertTextField
        // Loop through the reponder chain until we find UIAlertController
        while !(responder is UIAlertController) {
            responder = responder.next
        }
        let alert = responder as! UIAlertController
        // Perform input validation and enable Add Item button only when textField is not empty
        alert.actions[1].isEnabled = (alertTextField.text != "")
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
        
        itemArray = selectedCategory?.mjItems.sorted(byKeyPath: "toDoTime", ascending: true)

   
        tableView.reloadData()
    }
    
    
    //MARK: - SearchBar related delegate methodextension Double {

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        

   
           self.itemArray = self.itemArray?.filter("toDoTitle CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "toDoTitle", ascending: true)

            //    let myQueue = DispatchQueue(label: "myQueue No.1")

//        tableView.reloadData {
//            self.itemArray = self.selectedCategory?.mjItems.sorted(byKeyPath: "toDoTime", ascending: true)
//        }

            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.itemArray = self.selectedCategory?.mjItems.sorted(byKeyPath: "toDoTime", ascending: true)

    //    DispatchQueue.main.async {}
  //      self.itemArray = self.selectedCategory?.mjItems.sorted(byKeyPath: "toDoTime", ascending: true)
        
  //      load()


//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
//            // Your code with delay
//            self.itemArray = self.selectedCategory?.mjItems.sorted(byKeyPath: "toDoTime", ascending: true)
//        }
  
//        resetAfterRelaod(searchBar: searchBar) {
//             self.itemArray = self.selectedCategory?.mjItems.sorted(byKeyPath: "toDoTime", ascending: true)
//        }
        

        
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
            self.tableView.layoutIfNeeded()
            self.itemArray = self.selectedCategory?.mjItems.sorted(byKeyPath: "toDoTime", ascending: true)
        }


    }
    
    func resetAfterRelaod (searchBar: UISearchBar, completion : @escaping () -> Void) {
        self.itemArray = self.itemArray?.filter("toDoTitle CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "toDoTitle", ascending: true)
        self.tableView.reloadData()
        
        completion()
        
    }

    override func mjDeleteAction(at: IndexPath) {
        if let tempCategory = itemArray {
            do {
                try  mjRealm.write {
                    mjRealm.delete(tempCategory[at.row])
                }
            } catch {
                print(error)
            }
        }
    }
    
    

}

extension UITableView {
    func reloadData(completion:  @escaping () -> Void) {
        
        UIView.animate(withDuration: 2, animations:  { self.reloadData() }) { (isDoneDone) in
         
            if isDoneDone {
               //  completion()
                  print("finish the reload sir")
            } else {
              
            }
           
        }
//        UIView.animate(withDuration: 0, animations: { self.reloadData() })
//        { _ in completion() }
    }
}
