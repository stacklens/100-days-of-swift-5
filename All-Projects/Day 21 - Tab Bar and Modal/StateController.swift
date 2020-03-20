//
//  StateController.swift
//  Day 21 - Tab Bar and Modal
//
//  Created by 杜赛 on 2020/3/20.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import Foundation

struct StateData{
    var message: String?
}

//@JA - Protocol that view controllers should have that defines that it should have a function to setState
protocol StateControllerProtocol {
  func setState(state: StateController)
}

class StateController {
    var state:StateData = StateData()
}
