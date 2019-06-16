//
//  CategoryViewController.swift
//  ToDoEy
//
//  Created by JuanSpada on 13/06/2019.
//  Copyright © 2019 Juan-Spada. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    
     let realm = try! Realm()
    
    var categories : Results<Category>!

    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategories()
    }
    
    
    //mark : table view datasource methods
    
    override func tableView(_ tableView: UITableView , numberOfRowsInSection section: Int) -> Int {
       
        
        return categories?.count ?? 1
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        
        return cell
        
    }
    
    
    //mark : add new categories
    
    
    //mark: table view delegate methods

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
   
    //mark: data manipulation methods
    func save(category: Category) {
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("error saving category \(error)" )
        }
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
         categories = realm.objects(Category.self)
        

         tableView.reloadData()
        }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add ", style: .default ){ (action) in
            
            
        
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            
           // newCategory.done = false
            
            
            self.save(category: newCategory)
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "create new category"
            textField = alertTextField
            
            
        }
        alert.addAction(action)
        
        present(alert , animated: true , completion: nil)
        
    
    
    }
    

}
