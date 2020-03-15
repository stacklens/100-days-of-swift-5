//
//  ViewController.swift
//  Day 3 - Tip Calculator
//
//  Created by 杜赛 on 2020/2/27.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    var amount: Float = 0.0 {
        didSet {
            updateDisplayAmount()
        }
    }
    
    var isPressedClearButton = false
    
    // textField
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.placeholder = "$0.00"
        }
    }
    
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    private var tipPercent: Float = 0.0 {
        didSet {
            tipLabel.text = "Tip(\(String(format: "%.02f", tipPercent * 100))%):     $\(String(format: "%.02f", amount * tipPercent))"
        }
    }
    private var total: Float = 0.0 {
        didSet {
            totalLabel.text = "Total:     $\(String(format: "%.02f", total))"
        }
    }
    
    // When slider value changes, update Label UI
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        tipPercent = sender.value
        total = (1 + tipPercent) * amount
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Dismiss keyboard by tap somewhere.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

}


extension ViewController: UITextFieldDelegate {
    
    // Update textField display UI
    private func updateDisplayAmount() {
        if let text = textField.text {
            let number = Double(text)
            if number == 0.0 || number == nil {
                textField.text = nil
            } else {
                textField.text = "$\(amount)"
            }
        }
    }
    
    // Collapse keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Translate textField.text to number
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !isPressedClearButton {
            if amount == 0 {
                textField.text = ""
            } else {
                textField.text = "\(amount)"
            }
        }
        isPressedClearButton = false
        return true
    }
    
    // Mark the Clear button was pressed
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        isPressedClearButton = true
        return true
    }
    
    // Make sure input is a validate number
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, string == "." {
            if text.contains(".") || text.first == nil {
                return false
            }
        }
        return true
    }
    
    // Transform amout to display string
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        amount = Float(text) ?? 0.0
    }
    
}
