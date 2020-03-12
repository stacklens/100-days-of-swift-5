//
//  PhotoAssets.swift
//  Day 16 - Save Date Location Photo
//
//  Created by 杜赛 on 2020/3/10.
//  Copyright © 2020 Du Sai. All rights reserved.
//

//import UIKit
//import CoreLocation
//import Photos
//
//struct PhotoAssets {
//    static let allAssetsInLibrary: [PhotoAsset] = {
//
//        var items = [PhotoAsset]()
//
//        let manager = PHImageManager.default()
//        let requestOptions = PHImageRequestOptions()
//        requestOptions.isSynchronous = false
//        requestOptions.deliveryMode = .opportunistic
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//
//        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//        if results.count > 0 {
//            for i in 0..<results.count {
//                let asset = results.object(at: i)
//                let size = CGSize(width: 700, height: 700)
//                manager.requestImage(
//                for: asset,
//                targetSize: size,
//                contentMode: .aspectFit,
//                options: requestOptions
//                )
//                { (image, _) in
//                    if let image = image {
//                        var item = PhotoAsset(image: image, date: asset.creationDate, location: asset.location)
//                        items.append(item)
//                    } else {
//                        print("error asset to image")
//                    }
//                }
//            }
//        } else {
//            print("no photos to display")
//        }
//
//        return items
//    }()
//
//
//
//}
