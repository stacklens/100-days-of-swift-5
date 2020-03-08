//
//  UITextField+isEmpty.swift
//  Day 13 - Dynamic Data for Each Cell
//
//  Created by 杜赛 on 2020/3/8.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

extension UITextField {
    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty {
            return false
        }
        return true
    }
}
