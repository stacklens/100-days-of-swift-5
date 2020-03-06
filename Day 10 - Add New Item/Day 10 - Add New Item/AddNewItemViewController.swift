//
//  AddNewItemViewController.swift
//  Day 10 - Add New Item
//
//  Created by 杜赛 on 2020/3/1.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    // Send message from this contrller to TableViewController by Closure.
    // Also can send message back by Delegate.
    var addItemHandler: ((String) -> ())?
    // This function would call when user press Return Key.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, text != "" {
            addItemHandler?(text)
            navigationController?.popViewController(animated: true)
        }
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }

}
