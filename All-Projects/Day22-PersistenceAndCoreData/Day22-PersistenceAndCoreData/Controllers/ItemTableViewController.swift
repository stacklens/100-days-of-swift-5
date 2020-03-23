//
//  ItemTableViewController.swift
//  Day22-PersistenceAndCoreData
//
//  Created by 杜赛 on 2020/3/22.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
}

class ItemTableViewController: UITableViewController, UISearchBarDelegate
{
    
    private let context = AppDelegate.viewContext
    
    var category: Category?
    
    private var items: [Item]? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input new title here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text, let category = self.category {
                let newItem = Item.create(in: self.context, title: name, linkedWith: category)
                self.items?.append(newItem)
            }
        })
        )
        
        self.present(alert, animated: true)
    }
    
    private func updateUI() {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        if let category = category {
            items = Item.itemsOfCategory(in: context, linkedWith: category)
        } else {
            items = []
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item Cell", for: indexPath) as! ItemTableViewCell

        // Configure the cell...
        if let item = items?[indexPath.row] {
            cell.titleLabel.text = item.title
            if item.finished {
                cell.contentView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            } else {
                cell.contentView.backgroundColor = .clear
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.selectionStyle = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell {
                cell.titleLabel.transform = .init(scaleX: 5, y: 5)
                cell.contentView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, animations: {
            if let cell = tableView.cellForRow(at: indexPath) as? ItemTableViewCell {
                cell.titleLabel.transform = .identity
                if let item = self.items?[indexPath.row] {
                    if !item.finished {
                        cell.contentView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                    } else {
                        cell.contentView.backgroundColor = .clear
                    }
                }
            }
        }, completion: { finished in
            self.items?[indexPath.row] .changeFinishStatus(in: self.context)
        })
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.first != nil, let category = category {
            items = Item.searchInCategory(in: context, title: searchText, linedWith: category)
        } else {
            if let category = category {
                items = Item.itemsOfCategory(in: context, linkedWith: category)
            } else {
                items = []
            }
        }
    }

}
