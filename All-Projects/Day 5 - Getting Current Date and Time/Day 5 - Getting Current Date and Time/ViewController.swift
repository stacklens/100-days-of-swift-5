//
//  ViewController.swift
//  Day 5 - Getting Current Date and Time
//
//  Created by 杜赛 on 2020/2/29.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currentDateAndTime: UILabel! {
        didSet {
            updateUI()
        }
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        updateUI()
    }
    
    private func updateUI() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        let dateString = formatter.string(from: date)
        currentDateAndTime.text = dateString
        currentDateAndTime.sizeToFit()
    }


}

