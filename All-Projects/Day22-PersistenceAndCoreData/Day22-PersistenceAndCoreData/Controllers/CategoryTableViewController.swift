//
//  CategoryTableViewController.swift
//  Day22-PersistenceAndCoreData
//
//  Created by 杜赛 on 2020/3/22.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
}

class CategoryTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate
{
    private var categorys = [Category]() {
        didSet {
            updateUI()
        }
    }
    
    let context = AppDelegate.viewContext
    
    let cellBgColor = [CGFloat.random, CGFloat.random, CGFloat.random]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadAllCategory()
    }
    
    private func updateUI() {
        tableView.reloadData()
    }
    
    private func loadAllCategory() {
        categorys = Category.all(in: context)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categorys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category Cell", for: indexPath) as! CategoryTableViewCell

        // Configure the cell...
        cell.titleLabel.text = categorys[indexPath.row].title
        cell.contentView.backgroundColor = UIColor(red: cellBgColor[0], green: cellBgColor[1], blue: cellBgColor[2], alpha: CGFloat(1.0 / (Double(indexPath.row) + 1.0)))
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .fade)
                let obj = category.remove(at: indexPath.row)
                Category.delete(in: context, obj: obj)
            })
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            tableView.performBatchUpdates({
                // Do something with editing here.
                let alert = UIAlertController(title: "Editing title", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                alert.addTextField(configurationHandler: { textField in
                    textField.placeholder = "Input new title here..."
                })
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        if let name = alert.textFields?.first?.text {
                            _ = Category.update(in: self.context, obj: self.categorys[indexPath.row], title: name)
                            self.updateUI()
                        }
                    })
                )
                
                self.present(alert, animated: true)
            })
            completionHandler(true)
        }
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .fade)
                let obj = self.categorys.remove(at: indexPath.row)
                Category.delete(in: self.context, obj: obj)
            })
            completionHandler(true)
        }
        
        editAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        editAction.image = UIImage(systemName: "pencil.tip")
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        deleteAction.image = UIImage(systemName: "trash.fill")
        let configuration = UISwipeActionsConfiguration(actions: [editAction, deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categorys[indexPath.row]
        performSegue(withIdentifier: "Go to Items", sender: selectedCategory)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Add New Category", let popoverVC = segue.destination as? CategoryPopoverViewController {
            popoverVC.popoverPresentationController?.delegate = self
            popoverVC.preferredContentSize = CGSize(width: 400, height: 120)
            popoverVC.context = context
            popoverVC.returnKeyPressedCallback = { [weak self] in
                self?.loadAllCategory()
            }
        }
        else if segue.identifier == "Go to Items",
            let nvc = segue.destination as? ItemTableViewController,
            let category = sender as? Category
        {
            nvc.category = category
        }
    }

}
