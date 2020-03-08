//
//  ContactTableViewController.swift
//  Day 13 - Dynamic Data for Each Cell
//
//  Created by 杜赛 on 2020/3/4.
//  Copyright © 2020 Du Sai. All rights reserved.
//

// This app based on IQKeyboardManager framework.
// Please open this app through 'Day 13 - Dynamic Data for Each Cell.xcworkspace'.

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
}

class ContactTableViewController: UITableViewController {
    
    // Model load here.
    var friends: [Friend] = Friends.allFriends(in: "dict") ?? [] {
        didSet {
            Friends.save(by: friends, in: "dict")
            tableView.reloadData()
        }
    }
    
    let sectionTitle = ["Recent", "Friends"]
    lazy var recentFriendsCount = friends.prefix(2).count
    
    // Raw friends data is in bundle.main.path -> dict.json
    // When app first start, raw friends data will copy to document dir -> dict.json
    // If this IBAction tapped, data in document will be refreshed from bundle.main.path again.
    @IBAction func refreshDataFromDict(_ sender: UIBarButtonItem) {
        if let fileURL = Friends.documentFileURL {
            if let reloadedData = Friends.copyDataToDoc(from: "dict", to: fileURL) {
                friends = reloadedData
                tableView.reloadData()
            }
        }
    }
    
    // Add new friend
    @IBAction func addNewFriend(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Contact Create", sender: sender)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == sectionTitle.firstIndex(of: "Recent"){
            return recentFriendsCount
        }
        return friends.count - recentFriendsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Friend Cell", for: indexPath) as! ContactTableViewCell

        if indexPath.section == sectionTitle.firstIndex(of: "Recent") {
            setCellAttr(cell, at: indexPath.row)
        } else {
            setCellAttr(cell, at: indexPath.row + recentFriendsCount)
        }
        return cell
    }
    
    // Note: Parameter "cell" is referrence type
    private func setCellAttr(_ cell: ContactTableViewCell, at index: Int) {
        let friend = friends[index]
        cell.name.text = friend.name
        cell.avatar.image = UIImage(named: friend.avatar ?? "avatar01")
        // circelCorner is an extension of UIImageView
        // can get an circle corner radius imageView
        cell.avatar.circleCorner()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    // Support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if indexPath.section == sectionTitle.firstIndex(of: "Recent") {
                tableView.performBatchUpdates({
                    friends.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    recentFriendsCount = recentFriendsCount - 1
                })
            } else {
                tableView.performBatchUpdates({
                    friends.remove(at: indexPath.row + recentFriendsCount)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                })
            }
    
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.section * recentFriendsCount + indexPath.row
        var friend = friends[index]
        friend.index = index
        performSegue(withIdentifier: "Contact Detail", sender: friend)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Contact Detail", let nvc = segue.destination as? ContactDetailViewController {
            nvc.friend = sender as? Friend
            nvc.saveFirendData = { [weak self] friend in
                if let index = friend.index, self != nil {
                    self!.friends.replaceSubrange(index ..< index + 1, with: [friend])
                }
            }
        } else if segue.identifier == "Contact Create", let nvc = segue.destination as? ContactCreateViewController {
            nvc.saveData = { [weak self] in
                if let newFriend = nvc.newFriend {
                    self?.friends.append(newFriend)
                }
            }
        }
    }

}
