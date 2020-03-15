//
//  UIImageExtension.swift
//  Day 13 - Dynamic Data for Each Cell
//
//  Created by 杜赛 on 2020/3/7.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

extension UIImageView {
    func circleCorner() {
        self.layer.cornerRadius = self.frame.width / 2
    }
}
