//
//  ViewController.swift
//  Todoey
//
//  Created by Jun Miao on 18/04/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import UIKit
import CoreData

class ToDoeyViewController: UITableViewController {

 //   var itemArray = [ToDoListModel]()
    
   var itemArray = [MJItem]()
    var theChecked : Bool = false
    
    let mjDefaults = UserDefaults.standard
    
    let mjFileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("mjitem.plist")
    
    let mjDic = ["name" : "miaoJun" , "gender" : "male"]
    let mjArray = [1,2,3,4,5,6]
    
    
    let mjAppdelegate = (UIApplication.shared.delegate as! AppDelegate)
    let mjContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPressedGesture.minimumPressDuration = 1
        self.view.addGestureRecognizer(longPressedGesture)
        
        load()
 
//        if let tempfile = mjFileDirectory   {
//            do {
//                let mjReadData = try Data(contentsOf: tempfile)
//                let mjDecoder = PropertyListDecoder()
//
//                itemArray = try mjDecoder.decode([ToDoListModel].self, from: mjReadData)
//            } catch {
//                print("seems the file not exist")
//            }
//        }

       
        
   //     mjDecoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
        
        
        
// 如下3行是为了测试String是否也是encodable,不是，但改成dictionary后就可以了，那是应为这是PropertyListEncoder所以。。。。
//        let mjEncoderFirst = PropertyListEncoder()
//    let mjEncodedDataFirst =  try!  mjEncoderFirst.encode(mjArray)
//
//    try!    mjEncodedDataFirst.write(to: mjFileDirectory!)

        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let tempArray =  mjDefaults.array(forKey: "mjToDoList") as? [String] {
//              itemArray = tempArray
//        }
      
        
 //      mjDefaults.set("good morning", forKey: "mjToDoList")
        
//        for _ in 0 ... 5 {
//            itemArray.append(ToDoListModel(title: "a test"))
//        }
        
    //  mjDefaults.set(itemArray, forKey: "thisistest")    当ItemArray 是class 的array时 default已经不接受了，因为太复杂了
        
        
    }


    //MARK:-  datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        
        return itemArray.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = itemArray[indexPath.row].toDoTitle
        
        cell.accessoryType = itemArray[indexPath.row].toDoCheck ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        
//        if itemArray[indexPath.row].toDoCheck == false {
//            cell.accessoryType = UITableViewCellAccessoryType.none
//        }else {
//            cell.accessoryType = UITableViewCellAccessoryType.checkmark
//        }
        
     //   cell.textLabel?.text = itemArray[indexPath.row]
        cell.backgroundColor = UIColor.blue
     //  tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark  // 很显然这个函数应该是tableview都已经形成后才能使用的。是在delegate使用的函数
        // 在datasource里 是正在建立这个cell 所以肯定要用dequeResuableCell 这个函数先建立cell

        

        
        return cell
        
    }
    
    //MARK:- delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        
   //   tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].toDoCheck = !itemArray[indexPath.row].toDoCheck
        
        save()
        
//        if  itemArray[indexPath.row].toDoCheck == false {
//            itemArray[indexPath.row].toDoCheck = true
//        }else {
//            itemArray[indexPath.row].toDoCheck = false
//        }

    tableView.reloadData()
        
     //   tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType(rawValue: 0)!
        
      
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
//        }else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
//        }

      
      
    }

    //MARK:- barButton pressed
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
//        var mjInput : String = "thisisold value" {
//            willSet {
//                print("here is the newvalue : \(newValue) \n")
//            }
//            didSet {
//                print("here is the oldValue:  \(oldValue) \n")
//            }
//        }
        
   //     var mjInput : UITextField?
        
        let mjAlert = UIAlertController(title: "Title :PLS add new Item Sir", message: "get some new item message ", preferredStyle: .alert)
        
        mjAlert.addAction(UIAlertAction(title: "very good", style: .default, handler: { (yourAction) in
            
//            if let tempInput = mjInput {
//                self.itemArray.append(tempInput.text!)
//                self.tableView.reloadData()
//            }
            
          //  let tempItem = ToDoListModel(title: mjAlert.textFields![0].text!)
            
            let tempItem = MJItem(context: self.mjContext)
            
            tempItem.toDoTitle = mjAlert.textFields![0].text!
            tempItem.toDoCheck = false
            
            
            self.itemArray.append(tempItem)
            
            
            self.save()
           
            
       //     self.itemArray.append(mjAlert.textFields![0].text!)
        //    self.mjDefaults.set(self.itemArray, forKey: "mjToDoList")
            
            self.tableView.reloadData()

            
        }))
        mjAlert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        mjAlert.addTextField { (yourInput) in
            
     //            mjInput =  yourInput
      
           
        }
        mjAlert.addTextField { (secondInput) in
            //
        }
        
        
        present(mjAlert, animated: true, completion: nil)
        
    }
    
    //MARK: - load and save data
    
    func save () {
        
mjAppdelegate.saveContext()

        
    
    }
    
    
    func load () {
        
        let myRequest : NSFetchRequest<MJItem>  = MJItem.fetchRequest()
        
        do {
               try  itemArray = mjContext.fetch(myRequest)
        }
        catch {
            print(error)
        }
   
        
    }
    
    
    
    
    

}

