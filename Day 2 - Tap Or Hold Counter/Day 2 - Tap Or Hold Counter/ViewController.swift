//
//  ViewController.swift
//  Day 2 - Tap Or Hold Counter
//
//  Created by 杜赛 on 2020/2/27.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private var count = 0 {
        didSet {
            updateUI()
        }
    }

    // Gesture
    var lastPressTime = Date().timeIntervalSince1970
    @IBOutlet var longPressGesture: UILongPressGestureRecognizer!
    @IBAction func longPressGestureAction(_ sender: UILongPressGestureRecognizer) {
        let currentPressTime = Date().timeIntervalSince1970
        // Counter increase once 0.1 second
        guard currentPressTime - lastPressTime > 0.1 else { return }
        lastPressTime = currentPressTime
        count += 1
        updateUI()
    }
    
    // Button
    @IBOutlet weak var tapOrHold: UIButton!
    @IBAction func tapOrHoldBtn(_ sender: UIButton) {
        count += 1
        updateUI()
    }
    
    // Label
    @IBOutlet weak var countNumber: UILabel!
    
    // Reset
    @IBAction func resetCounter(_ sender: UIBarButtonItem) {
        count = 0
        updateUI()
    }
    
    private func updateUI() {
        countNumber.text = "\(count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapOrHold.addGestureRecognizer(longPressGesture)
    }}

