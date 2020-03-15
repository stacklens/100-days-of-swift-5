//
//  Int+arc4Random.swift
//  Day 13 - Dynamic Data for Each Cell
//
//  Created by 杜赛 on 2020/3/8.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import Foundation

extension Int {
    var arc4Random: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max..<0:
            return Int(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
    }
}
