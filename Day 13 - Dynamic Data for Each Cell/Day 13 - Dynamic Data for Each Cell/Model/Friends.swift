//
//  Friends.swift
//  Day 13 - Dynamic Data for Each Cell
//
//  Created by 杜赛 on 2020/3/5.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import Foundation

struct Friends: Codable {
    // Get an Array? contains all friends from dict.json
    static func allFriends(in file: String) -> [Friend]? {
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                if let users = try? JSONDecoder().decode([Friend].self, from: jsonData) {
                    return users
                }
            }
        }
        return nil
    }
}
