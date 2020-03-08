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
    
    static func save(by friends: [Friend], in file: String) {
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            if let jsonData = try? JSONEncoder().encode(friends) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    do {
                        let url = URL(fileURLWithPath: path)
                        print(url)
                        try jsonString.write(to: url, atomically: true, encoding: .utf8)
                    } catch {
                        print(Error.self)
                    }
                }
            }
        }
    }
}
