//
//  ViewController.swift
//  Day23-IntoTheDark
//
//  Created by 杜赛 on 2020/3/24.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var labels: [UILabel]!
    private let grayColors: [UIColor] = [.systemGray, .systemGray2, .systemGray3, .systemGray4, .systemGray5, .systemGray6]
    @IBOutlet weak var colorSet1: UIView!
    @IBOutlet weak var colorSet2: UIView!
    
    @IBAction func changeInterfaceStyle(_ sender: UISwitch) {
        if sender.isOn {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for (index, label) in labels.enumerated() {
            label.textColor = grayColors[index]
        }
        
        colorSet1.backgroundColor = UIColor(named: "Color1")
        colorSet2.backgroundColor = UIColor(named: "Color2")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // Perform some code here when the interface style changed..
    }

}

