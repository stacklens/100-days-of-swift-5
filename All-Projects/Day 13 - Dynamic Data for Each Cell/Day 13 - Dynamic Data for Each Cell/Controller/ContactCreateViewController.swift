//
//  ContactCreateViewController.swift
//  Day 13 - Dynamic Data for Each Cell
//
//  Created by 杜赛 on 2020/3/8.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ContactCreateViewController: UIViewController, UITextFieldDelegate
{
    var newFriend: Friend?
    var saveData: (() -> ())?
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField! { didSet { name.delegate = self }}
    @IBOutlet weak var mobile: UITextField! { didSet { mobile.delegate = self }}
    @IBOutlet weak var email: UITextField! { didSet { email.delegate = self }}
    @IBOutlet weak var notes: UITextView! { didSet { notes.isEditable = false }}
    
    
    @IBOutlet weak var done: UIBarButtonItem!
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        guard !name.isEmpty else {
            name.becomeFirstResponder()
            return
        }
        
        newFriend = Friend()
        
        newFriend?.avatar = "avatar0\(9.arc4Random + 1)"
        newFriend?.name = name.text ?? "Unnamed"
        newFriend?.mobile = mobile.text ?? ""
        newFriend?.email = email.text ?? ""
        newFriend?.notes = notes.text
        
        saveData?()
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.becomeFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
