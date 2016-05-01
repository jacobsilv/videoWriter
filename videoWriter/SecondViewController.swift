//
//  SecondViewController.swift
//  videoWriter
//
//  Created by Anthony Salazar on 4/29/16.
//  Copyright (c) 2016 nyu.edu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var data: String?
    var frameNumber: Int = 0
    var images : NSMutableArray = []
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var frameChooser: UICollectionView!
    @IBOutlet weak var frameNumberLabel: UILabel!
    @IBOutlet weak var switchState: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameChooser.backgroundColor = UIColor.whiteColor();
        self.frameChooser.dataSource = self;
        self.frameChooser.delegate = self;
        
        if let label = data {
            switchState.text = data
        }
        
        frameNumberLabel.text = String(frameNumber)
        frameChooser.reloadData()
        //initializes images[] with null values (0's) so that images can be swapped with the different frames out of order.
        var i: Int
        for(i=0; i<frameNumber;i=i+1) {
            images.addObject(0);
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameNumber
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //create new cell object for each cell in collection
        var cell: ImageCell
        cell = frameChooser.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ImageCell
        
        //cell styling
        cell.layer.cornerRadius = 4
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.blackColor().CGColor

        
        //this shows how this function loops through each cell:
        cell.label.text = String(indexPath.item)
        
        
        //this is intended to populate each cell's imageview with image:
        if(images.objectAtIndex(indexPath.item) as! NSObject != 0) {
            cell.imageCell.image = images.objectAtIndex(indexPath.item) as? UIImage
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //this is triggered when you selected a cell
        NSLog("Cell \(indexPath.row) selected")
        
        //this opens photo library
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        NSLog("yeah")
        
        
        //This isn't being triggered but should in, which the following code should append images[] array and reload data should re-populate the cells, retriggering the above function that generates cells
        
        
//        images.addObject((info[UIImagePickerControllerOriginalImage] as? UIImage)!)
//        self.dismissViewControllerAnimated(true, completion: {})
//        frameChooser.reloadData()
//        NSLog(String(images.count))
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        NSLog("cancelled")
        self.imagePicker = UIImagePickerController()
        dismissViewControllerAnimated(true, completion: nil)
    }
}

