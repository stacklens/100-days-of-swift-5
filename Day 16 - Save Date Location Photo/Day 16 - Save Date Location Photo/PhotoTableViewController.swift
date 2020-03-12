//
//  PhotoTableViewController.swift
//  Day 16 - Save Date Location Photo
//
//  Created by 杜赛 on 2020/3/10.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit
import Photos
import CoreLocation

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
}

class PhotoTableViewController: UITableViewController, CLLocationManagerDelegate
{
    
    private var photoAssets = [PhotoAsset]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let libraryStatus = PHPhotoLibrary.authorizationStatus()
        switch libraryStatus {
        case .denied, .restricted:
            print("Library Authorization failed.")
        case .authorized:
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                print("Library authorization ok.")
            }
        @unknown default:
            print("Unknown default.")
        }
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        let locationStatus = CLLocationManager.authorizationStatus()
        switch locationStatus {
        case .denied, .restricted:
            print("Error 0")
        case .authorizedWhenInUse, .authorizedAlways:
            break
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        default:
            print("Unknown fail.")
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photoAssets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo Cell", for: indexPath) as! PhotoTableViewCell

        // Configure the cell...
        let asset = photoAssets[indexPath.row]
        cell.photoImageView.image = asset.image
        cell.dateLabel.text = asset.dateString
        cell.locationLabel.text = asset.locationString
//        cell.dateLabel.text = asset.date?.formatToString(of: .full)
//        cell.locationLabel.text = asset.location?.formatToString()

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Add Asset",
            let nvc = segue.destination as? AddNewAssetViewController
        {
            nvc.saveAssetHandler = { [weak self] in
                self?.photoAssets.append(nvc.asset)
            }
        }
    }

}
