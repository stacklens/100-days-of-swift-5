//
//  ViewController.swift
//  Day 8 - Add Photo from Camera Roll
//
//  Created by 杜赛 on 2020/3/1.
//  Copyright © 2020 Du Sai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var cameraButton: UIBarButtonItem! {
        didSet {
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        }
    }
    
    // Open photo library
    @IBAction func takeImage(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // Cancel pick photo
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.presentingViewController?.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = ((info[.editedImage] ?? info[.originalImage]) as? UIImage) {
            print(image)
            let textAttachment = NSTextAttachment()
            // Change image scale here
            let oldWidth = image.size.width;
            let scaleFactor = oldWidth / (textView.frame.size.width - 10); //for the padding inside the textView
            textAttachment.image = UIImage(cgImage: image.cgImage!, scale: scaleFactor, orientation: .up)
            let attrStringWithImage = NSAttributedString(attachment: textAttachment)
            // Append image to the textField
            let attributedString = NSMutableAttributedString(attributedString: textView.attributedText)
            attributedString.append(attrStringWithImage)
            textView.attributedText = attributedString;
        }
        picker.presentingViewController?.dismiss(animated: true)
    }
    
}

