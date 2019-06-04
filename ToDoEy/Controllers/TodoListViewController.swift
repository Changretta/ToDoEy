//
//  ViewController.swift
//  ToDoEy
//
//  Created by JuanSpada on 01/06/2019.
//  Copyright © 2019 Juan-Spada. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
      
        loadItems()
        
        
        // Do any additional setup after loading the view.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default , reuseIdentifier: "ToDoItemCell")
        
        let item = itemArray[indexPath.row]
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell" ,for: indexPath )
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done  ? .checkmark : .none
        
        
        
        return cell
    }


    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done == !ItemArray[indexPath.row].done
        
        saveItems()
        
        
        
        
        tableView.deselectRow(at: <#T##IndexPath#>, animated: true)
    }
    
    //Mark add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default ){ (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
         self.itemArray.append(newItem)
            
            
         saveItems()
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
            
            
        }
        alert.addAction(action)
        
        present(alert , animated: true , completion: nil)
        
        }
    
    
    

}

func saveItems() {
    let encoder = PropertyListEncoder()
    
    
    do {
        let data = encoder.encode(.itemArray)
        try data.write(to : .dataFilePath!)
    } catch {
        print("encoding error, \(error)")
    }
    
    self.tableView.reloadData()
    
    loadItems(){
       if  let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
        do {
            itemArray = decoder.decode([Item].self, from: data )
        }    catch {
            print("error decoding , \(error)")
        }
        
        }
        
    }
}
