//
//  ContactDetailViewController.swift
//  Day 13 - Dynamic Data for Each Cell
//
//  Created by 杜赛 on 2020/3/6.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var friend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(friend?.name)
        // Do any additional setup after loading the view.
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
