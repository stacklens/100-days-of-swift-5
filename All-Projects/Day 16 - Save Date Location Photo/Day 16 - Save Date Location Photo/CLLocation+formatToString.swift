//
//  CLLocation+formatToString.swift
//  Day 16 - Save Date Location Photo
//
//  Created by 杜赛 on 2020/3/10.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    func formatToString() -> String {
        let geoCoder = CLGeocoder()
        
        var text = "ttt"
        
        // For some unknown reason, when I use a GPS address outside China, the reverseGeocodeLocation() method reports an error.
        // So I manually assign a GPS value(Hong Kong) to loc, which should not be.
        // If you don't have the same problem as me, please comment out the assignment statement below, and replace "loc" to "self".
        let loc = CLLocation(latitude: CLLocationDegrees(22.275), longitude: CLLocationDegrees(114.165))
        
        geoCoder.reverseGeocodeLocation(loc) { (placemarks, error) in
            if let err = error {
                print(err)
            } else if let placemarkArray = placemarks {
                if let placemark = placemarkArray.first {
                    text = "\(placemark.name ?? "UnknownName"), \(placemark.locality ?? "UnknownLocality"), \(placemark.country ?? "UnknownCountry")"
                } else {
                    print("Placemark not found.")
                }
            } else {
                print("Unknown error.")
            }
        }
        
        return text
    }
}
