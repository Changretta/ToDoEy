//
//  ViewController.swift
//  ToDoEy
//
//  Created by JuanSpada on 01/06/2019.
//  Copyright © 2019 Juan-Spada. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController,  {
    
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet { loadItems()
    }
    }
   // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: documentDirectory, in: .userDomainMask))
        

        
        
        
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
        
        //    context.delete(itemArray[indexPath.row])
        //    itemArray.remove(at: indexPath.row)
       
        
       itemArray[indexPath.row].done == !itemArray[indexPath.row].done
        
        saveItems()
        
        
        
        
        tableView.deselectRow(at: indexPath , animated: true)
    }
    
    //Mark add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default ){ (action) in
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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


 // mark model manipulation method
func saveItems() {
    
    
    
    do {
     try  context.save()
    } catch {
        print("error saving \(error)")
    }
    
    self.tableView.reloadData()
 
}
func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
    
    let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!name!)
    
    if let additionalPredicate = predicate {
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate , additionalPredicate])
        
    } else {
        request.predicate = categoryPredicate
    }
    
    
    // Other older solution
    //    let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
    //    request.predicate = compoundPredicate
        
        
        do {
            itemArray = try context.fetch(request)
        
        } catch {
            print("error fetching \(error)")
        }
        
    }
    
 }
// Mark search bar method
    extension TodoListViewController: UISearchBarDelegate {
    searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let request : NSFetchRequest<Item> = Item.fetchRequest()
    
    request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    
    
    request.sortDescriptors = [NSSortDecriptor(key: "title", ascending: true)]
    
        loadItems(with :request , predicate :)
    
  

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
