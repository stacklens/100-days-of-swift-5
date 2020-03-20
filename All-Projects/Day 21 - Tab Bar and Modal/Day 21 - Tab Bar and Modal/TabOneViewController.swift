//
//  TabOneViewController.swift
//  Day 21 - Tab Bar and Modal
//
//  Created by 杜赛 on 2020/3/19.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class TabOneViewController: UIViewController, StateControllerProtocol
{
    func setState(state: StateController) {
        self.stateController = state
    }
    var stateController: StateController?
    
    @IBOutlet weak var label: UILabel!
    
    func labelAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.label.layer.opacity = 1
        }
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 1.0
        pulse.toValue = 0.8
        pulse.autoreverses = true
        pulse.initialVelocity = 0.8
        label.layer.add(pulse, forKey: nil)
        label.isHidden = false
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Do you want to learn swift well?", message: "Why not?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: goodAnswerHandler))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: badAnswerHandler))

        self.present(alert, animated: true)
    }
    
    lazy var goodAnswerHandler: ((UIAlertAction) -> Void) = { [weak self] action in
        self?.labelAnimation()
    }
    
    lazy var badAnswerHandler: ((UIAlertAction) -> Void) = { [weak self] action in
        let alert = UIAlertController(title: "Do you love swift?", message: "Strengthen your faith!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: self?.goodAnswerHandler))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: self?.worseAnswerHandler))
        
        self?.present(alert, animated: true)
    }
    
    lazy var worseAnswerHandler: ((UIAlertAction) -> Void) = { [weak self] action in
        let alert = UIAlertController(title: "Forget it, let me help you make a decision!", message: "...", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Only yes!", style: .default, handler: self?.goodAnswerHandler))
        
        self?.present(alert, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.layer.opacity = 0
    }


}
