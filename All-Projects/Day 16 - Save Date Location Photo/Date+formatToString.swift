//
//  Date+defaultFormat.swift
//  Day 16 - Save Date Location Photo
//
//  Created by 杜赛 on 2020/3/10.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import Foundation

extension Date {
    func formatToString(of style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        return formatter.string(from: self)
    }
}
