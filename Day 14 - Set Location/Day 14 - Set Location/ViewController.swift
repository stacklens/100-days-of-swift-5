//
//  ViewController.swift
//  Day 14 - Set Location
//
//  Created by 杜赛 on 2020/3/9.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate
{
    
    private var locationManager: CLLocationManager?

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBAction func refreshButton(_ sender: UIButton) {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .denied, .restricted:
            // do some warning here if user denied authorize.
            return
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.requestLocation()
        @unknown default:
            print("Get authorization fail.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if var lastLocation = locations.last {
            
            let geoCoder = CLGeocoder()
            
            // For some unknown reason, when I use a GPS address other than China, the reverseGeocodeLocation() method reports an error.
            // So I manually assign a GPS value(Hong Kong) to lastLocation, which should not be.
            // If you don't have the same problem as me, please comment out the assignment statement below.
            lastLocation = CLLocation(latitude: CLLocationDegrees(22.275), longitude: CLLocationDegrees(114.165))
            
            geoCoder.reverseGeocodeLocation(lastLocation) { [weak self] (placemarks, error) in
                if let err = error {
                    print(err)
                } else if let placemarkArray = placemarks {
                    if let placemark = placemarkArray.first {
                        self?.locationLabel.text = "\(placemark.name ?? "UnknownName"), \(placemark.locality ?? "UnknownLocality"), \(placemark.country ?? "UnknownCountry")"
                        self?.locationLabel.sizeToFit()
                    } else {
                        print("Placemark not found.")
                    }
                } else {
                    print("Unknown error.")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.requestWhenInUseAuthorization()
        
    }
}

