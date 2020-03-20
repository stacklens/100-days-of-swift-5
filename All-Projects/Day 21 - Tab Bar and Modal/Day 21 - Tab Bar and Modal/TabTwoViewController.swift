//
//  TabTwoViewController.swift
//  Day 21 - Tab Bar and Modal
//
//  Created by 杜赛 on 2020/3/20.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class TabTwoViewController: UIViewController, StateControllerProtocol
{
    func setState(state: StateController) {
        self.stateController = state
    }
    var stateController: StateController?
    
    private let message = "Msg from Action."
    
    @IBAction func actionsheetButtonPressed(_ sender: UIButton) {
    let alert = UIAlertController(title: "Do you want to Alert page?", message: message, preferredStyle: .actionSheet)
        
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: actionsheetHandler))
    alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: actionsheetHandler))

    self.present(alert, animated: true)
    }
    
    lazy var actionsheetHandler: ((UIAlertAction) -> Void) = { [weak self] action in
        if action.title == "Yes" {
            var firstTab = self?.tabBarController?.viewControllers?[0] as? TabOneViewController
            // firstTab?.label.text = self?.message
            firstTab?.labelAnimation()
            // StateController is a class shared between TabBarViewControllers, which is defined in scenedelegate.swift.
            self?.stateController?.state.message = self?.message
            firstTab?.label.text = self?.stateController?.state.message
            self?.tabBarController?.selectedIndex = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
