//
//  ViewController.swift
//  Day 6 - Passing Data to Another View
//
//  Created by 杜赛 on 2020/2/29.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    
    // MARK: - Navigation

    // Do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Go To The Second View" {
            if let vc = segue.destination as? SecondViewController {
                vc.messageStr = textView.text
            }
        }
    }
}

