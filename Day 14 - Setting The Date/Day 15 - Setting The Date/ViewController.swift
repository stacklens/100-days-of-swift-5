//
//  ViewController.swift
//  Day 14 - Setting The Date
//
//  Created by 杜赛 on 2020/3/10.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private(set) var date: Date?
    
    private(set) var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if date == nil {
            date = Date()
        }
    }
    
    @IBAction func setDateButton(_ sender: UIButton) {
        if let currentDate = date {
            navigationItem.title = dateFormatter.string(from: currentDate)
        }
    }
}

