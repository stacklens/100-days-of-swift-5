//
//  Friends.swift
//  Day 13 - Dynamic Data for Each Cell
//
//  Created by 杜赛 on 2020/3/5.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import Foundation

struct Friends: Codable {
    // Get Data file path (in document dir).
    static var documentFileURL: URL? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("dict.json")
            return fileURL
        }
        return nil
    }
    
    // Raw friends data is in bundle.main.path -> dict.json
    // When app first start, raw friends data will copy to document dir -> dict.json
    // If this IBAction tapped, data in document will be refreshed from bundle.main.path again.
    static func copyDataToDoc(from file: String, to fileURL: URL) -> [Friend]? {
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                if let users = try? JSONDecoder().decode([Friend].self, from: jsonData) {
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    try? jsonString?.write(to: fileURL, atomically: true, encoding: .utf8)
                    return users
                }
            }
        }
        return nil
    }
    
    
    // Get an Array? contains all friends from dict.json
    static func allFriends(in file: String) -> [Friend]? {
        if let fileURL = documentFileURL {
            // Check if document is reachable
            // If not, then copy file from bundle and read it.
            if (try? fileURL.checkResourceIsReachable()) ?? false {
                if let jsonData = try? Data(contentsOf: fileURL, options: .mappedIfSafe) {
                    if let users = try? JSONDecoder().decode([Friend].self, from: jsonData) {
                        return users
                    }
                }
            } else {
                return copyDataToDoc(from: file, to: fileURL)
            }
        }
        return nil
    }
    
    // Save Data to Document.
    static func save(by friends: [Friend], in file: String) {
        if let fileURL = documentFileURL {
            if let jsonData = try? JSONEncoder().encode(friends) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    do {
                        try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
                    } catch {
                    }
                }
            }

        }
    }
}
