//
//  ImageCell.swift
//  videoWriter
//
//  Created by Anthony Salazar on 4/30/16.
//  Copyright (c) 2016 nyu.edu. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell, UIImagePickerControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
//    @IBAction func clicked(sender: UIButton) {
//        NSLog("Cells clicked")
//        
//        //this opens photo library
//        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        ImageCell.presentViewController(imagePicker, animated: true, completion: nil)
////        
//        
//    }
    
}
