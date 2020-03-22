//
//  CategoryPopoverViewController.swift
//  Day22-PersistenceAndCoreData
//
//  Created by 杜赛 on 2020/3/22.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit
import CoreData

class CategoryPopoverViewController: UIViewController, UITextFieldDelegate
{
    
    var context: NSManagedObjectContext?

    @IBOutlet weak var textField: UITextField!
    
    var returnKeyPressedCallback: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
        textField.becomeFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let title = textField.text, title.first != nil, let context = context {
            textField.resignFirstResponder()
            _ = Category.create(in: context, title: title)
            returnKeyPressedCallback?()
            self.dismiss(animated: true)
            return true
        } else {
            return false
        }
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
