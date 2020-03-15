//
//  ViewController.swift
//  Day 1 - Tap Counter
//
//  Created by 杜赛 on 2020/2/26.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    var count = 0
    @IBOutlet weak var countLabel: UILabel! {
        didSet {
            updateUI()
        }
    }
    
    @IBAction func increaseCount(_ sender: UIButton) {
        count += 1
        updateUI()
    }
    
    @IBAction func resetCount(_ sender: UIBarButtonItem) {
        count = 0
        updateUI()
    }
    
    private func updateUI() {
        countLabel.text = "\(count)"
    }
}

