//
//  TabThreeViewController.swift
//  Day 21 - Tab Bar and Modal
//
//  Created by 杜赛 on 2020/3/20.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class TabThreeViewController: UIViewController, StateControllerProtocol
{
    func setState(state: StateController) {
        self.stateController = state
    }
    var stateController: StateController?

    @IBAction func showPopover(_ sender: UIButton) {
        performSegue(withIdentifier: "Popover", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
