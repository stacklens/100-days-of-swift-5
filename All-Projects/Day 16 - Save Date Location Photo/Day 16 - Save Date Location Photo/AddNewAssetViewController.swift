//
//  AddNewAssetViewController.swift
//  Day 16 - Save Date Location Photo
//
//  Created by 杜赛 on 2020/3/11.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit
import CoreLocation
import Photos

class AddNewAssetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate
{
    var asset = PhotoAsset()
    
    @IBOutlet weak var textView: UITextView!
    
    var saveAssetHandler: (() -> Void)?
    
    @IBAction func saveAssetButtonPressed(_ sender: UIBarButtonItem) {
        asset.note = textView.text
        if asset.image != nil {
            saveAssetHandler?()
        } else {
            print("Asset has no image. Please try again.")
        }
        navigationController?.popViewController(animated: true)
    }
    
    private lazy var toolBar: UIToolbar = {
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        bar.isTranslucent = false
        bar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // A space between left btn and right btn.
        let flexible = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: self,
            action: nil
        )
        
        bar.items = [self.cameraButton, locationButton, locationLabelButton, flexible, self.selectedImage]
        bar.sizeToFit()
        return bar
    }()
    
    private let cameraButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        btn.action = #selector(selectPhoto)
        btn.image = UIImage(systemName: "camera.fill")
        return btn
    }()
    
    private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return manager
    }()
    
    private let locationButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.action = #selector(getLocation)
        btn.image = UIImage(systemName: "location.fill")
        return btn
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var locationLabelButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(customView: self.locationLabel)
        return btn
    }()

    private lazy var selectedImage: UIBarButtonItem = {
        let btn = UIBarButtonItem(customView: self.selectedImageView)
        return btn
    }()
    
    private let selectedImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        return picker
    }()
    
    @objc private func selectPhoto() {
        present(imagePicker, animated: true)
    }
    
    @objc private func getLocation() {
        locationManager.requestLocation()
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = ((info[.editedImage] ?? info[.originalImage]) as? UIImage) {
            selectedImageView.image = image.scaleImage(toSize: CGSize(width: 20, height: 20))
            asset.image = image
            if let a = info[.phAsset] as? PHAsset {
                asset.dateString = a.creationDate?.formatToString(of: .full)
            }
        }
        picker.presentingViewController?.dismiss(animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if var lastLocation = locations.last {
            
            let geoCoder = CLGeocoder()
            
            // For some unknown reason, when I use a GPS address outside China, the reverseGeocodeLocation() method reports an error.
            // So I manually assign a GPS value(Hong Kong) to lastLocation, which should not be.
            // If you don't have the same problem as me, please comment out the assignment statement below.
            lastLocation = CLLocation(latitude: CLLocationDegrees(22.275), longitude: CLLocationDegrees(114.165))
            
            geoCoder.reverseGeocodeLocation(lastLocation) { [weak self] (placemarks, error) in
                if let err = error {
                    print(err)
                } else if let placemarkArray = placemarks {
                    if let placemark = placemarkArray.first {
                        let placemarkString = "\(placemark.name ?? "UnknownName"), \(placemark.locality ?? "UnknownLocality"), \(placemark.country ?? "UnknownCountry")"
                        self?.locationLabel.text = placemarkString
                        self?.locationLabel.sizeToFit()
                        self?.asset.locationString = placemarkString
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
        
        imagePicker.delegate = self
        locationManager.delegate = self
        
        textView.inputAccessoryView = toolBar
        textView.becomeFirstResponder()
    }

}
