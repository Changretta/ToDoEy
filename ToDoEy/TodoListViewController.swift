//
//  ViewController.swift
//  ToDoEy
//
//  Created by JuanSpada on 01/06/2019.
//  Copyright © 2019 Juan-Spada. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    let itemArray = ["find MIke", "Buy Eggs", "Destroy Demorgon "]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell" ,for: indexPath )
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if         tableView.cellForRow(at: <#T##IndexPath#>)?.accessoryType == .checkmark {
            tableView.cellForRow(at: <#T##IndexPath#>)?.accessoryType == .none

        } else {
            tableView.cellForRow(at: <#T##IndexPath#>)?.accessoryType = .checkmark

        }

        
        tableView.deselectRow(at: <#T##IndexPath#>, animated: true)
    }
    
}

