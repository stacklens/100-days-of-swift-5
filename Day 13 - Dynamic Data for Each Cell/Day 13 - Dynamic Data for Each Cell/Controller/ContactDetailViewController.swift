//
//  ContactDetailViewController.swift
//  Day 13 - Dynamic Data for Each Cell
//
//  Created by 杜赛 on 2020/3/6.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UITextFieldDelegate
{
    
    var friend: Friend?
    
    private var isTextFieldEditable = false {
        didSet {
            notes.isEditable = isTextFieldEditable
            if isTextFieldEditable {
                notes.becomeFirstResponder()
            } else {
                if var friendObj = friend {
                    view.endEditing(true)
                    friendObj.name = name.text ?? friendObj.name
                    friendObj.mobile = mobile.text ?? friendObj.mobile
                    friendObj.email = email.text ?? friendObj.email
                    friendObj.notes = notes.text
                    saveFirendData?(friendObj)
                }
            }
            edit.title = isTextFieldEditable ? "Done" : "Edit"
        }
    }
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField! { didSet { name.delegate = self }}
    @IBOutlet weak var mobile: UITextField! { didSet { mobile.delegate = self }}
    @IBOutlet weak var email: UITextField! { didSet { email.delegate = self }}
    @IBOutlet weak var notes: UITextView! { didSet { notes.isEditable = false }}
    
    @IBOutlet weak var edit: UIBarButtonItem!
    @IBAction func editContent(_ sender: UIBarButtonItem) {
        isTextFieldEditable = !isTextFieldEditable
    }
    
    var saveFirendData: ((_ friend: Friend) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let imageString = friend?.avatar, let image = UIImage(named: imageString) {
            avatar.image = image
            avatar.circleCorner()
        }
        name.text = friend?.name
        mobile.text = friend?.mobile
        email.text = friend?.email
        notes.text = friend?.notes
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return isTextFieldEditable
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
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
