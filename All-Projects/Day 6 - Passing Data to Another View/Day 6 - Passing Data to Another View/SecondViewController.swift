//
//  SecondViewController.swift
//  Day 6 - Passing Data to Another View
//
//  Created by 杜赛 on 2020/2/29.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var messageStr: String?
    
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        message.text = messageStr
    }
}
