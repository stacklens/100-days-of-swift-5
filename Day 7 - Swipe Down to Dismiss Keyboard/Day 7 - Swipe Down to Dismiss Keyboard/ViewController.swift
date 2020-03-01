//
//  ViewController.swift
//  Day 7 - Swipe Down to Dismiss Keyboard
//
//  Created by 杜赛 on 2020/3/1.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet var swipeDownGesture: UISwipeGestureRecognizer!
    
    @IBAction func swipeDown(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        swipeDownGesture.direction = .down
        view.addGestureRecognizer(swipeDownGesture)
        textField.becomeFirstResponder()
    }

}

