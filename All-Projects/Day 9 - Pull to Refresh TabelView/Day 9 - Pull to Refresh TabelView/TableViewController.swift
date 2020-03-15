//
//  TableViewController.swift
//  Day 9 - Pull to Refresh TabelView
//
//  Created by 杜赛 on 2020/3/1.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController
{
    
    var foods = ["Milk", "Apple"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add the refresh control to UIScrollView object.
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(handleRefreshControl),
            for: .valueChanged
        )
    }
    
    @objc func handleRefreshControl() {
        // Update tabel view content…
        foods.append(contentsOf: ["fish", "bread", "chiken", "Ham", "Egg"])
        // Dismiss the refresh control and reload data.
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
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
}
