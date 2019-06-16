//
//  ViewController.swift
//  ToDoEy
//
//  Created by JuanSpada on 01/06/2019.
//  Copyright © 2019 Juan-Spada. All rights reserved.
//

import UIKit

import RealmSwift

class ViewController: UITableViewController,  {
    
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
    }
    }
   // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: documentDirectory, in: .userDomainMask))
        

        
        
        
        // Do any additional setup after loading the view.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = UITableViewCell(style: .default , reuseIdentifier: "ToDoItemCell")
        
        if let item = todoItems?[indexPath.row] {
            
            //let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell" ,for: indexPath )
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done  ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "no items added"
            
        }
        
       
        
        
        return cell
    }


    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
                
                      item.done = !item.done
            }
        } catch {
                print("error saving done status , \(error)")
            }
        }
    
    tableView.reloadDate()
        
        
        
        
        
        tableView.deselectRow(at: indexPath , animated: true)
    }
    
    //Mark add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default ){ (action) in
            
            if let currentCategory = self.selectedCategory {
              
                do {
                try self.realm.write {
                    let newItem = Item()
                    
                    newItem.title = textField.text!
                    newItem.dateCreated = let Date()
                    currentCategory.items.append(newItem)
                    }
                } catch  {
                        print("there was an error adding a category , \(error)")
                    }
                }
            self.tableView.reloadData()
           
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
            
            
        }
        alert.addAction(action)
        
        present(alert , animated: true , completion: nil)
        
        }
    
    
    

}


 // mark model manipulation method

func loadItems(){

    itemArray = selectedCategory.items.sorted(byKeyPath: "title" , ascending: true )

        }
    tableView.reloadData()
    


// Mark search bar method

    extension TodoListViewController: UISearchBarDelegate {
    searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        }
 


    
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
            if searchBar.text?.count == 0 {
                loadItems()

                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            }
        }

}
