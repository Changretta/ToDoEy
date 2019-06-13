//
//  CategoryViewController.swift
//  ToDoEy
//
//  Created by JuanSpada on 13/06/2019.
//  Copyright © 2019 Juan-Spada. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    
    
     var categories = [Category]()
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    
    //mark : table view datasource methods
    
    override func tableView(_ tableView: UITableView , numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
   
    //mark: data manipulation methods
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("error saving category \(error)" )
        }
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
        categories = try context.fetch(request)
        } catch {
            print("error loading the data \(error) ")
        }
        tableView.reloadData()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add ", style: .default ){ (action) in
            
            
        
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
           // newCategory.done = false
            self.categories.append(newCategory)
            
            
            self.saveCategories()
        }
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "create new category"
            textField = alertTextField
            
            
        }
        alert.addAction(action)
        
        present(alert , animated: true , completion: nil)
        
    
    
    }
    

}
