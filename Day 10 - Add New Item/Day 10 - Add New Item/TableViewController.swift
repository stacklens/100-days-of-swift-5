//
//  TableViewController.swift
//  Day 10 - Add New Item
//
//  Created by 杜赛 on 2020/3/1.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var foods = ["Apple", "Orange", "Milk"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = foods[indexPath.row]

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the Closure to the new view controller.
        if segue.identifier == "Add New Item",
            let nvc = segue.destination as? AddNewItemViewController
        {
            nvc.addItemHandler = { [weak self] newItem in
                self?.foods.append(newItem)
                self?.tableView.reloadData()
            }
        }
    }

}
