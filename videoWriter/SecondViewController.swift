//
//  SecondViewController.swift
//  videoWriter
//
//  Created by Anthony Salazar on 4/29/16.
//  Copyright (c) 2016 nyu.edu. All rights reserved.
//

import UIKit
import ImageIO
import MobileCoreServices

class SecondViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var submitButton: UIButton!
    var data: String?
    var frameNumber: Int = 0
    var images : NSMutableArray = []
    var imagePicker = UIImagePickerController()
    var currentSelectedCell = -1;
    var looping = 0;
    var _fileURL:NSURL?

    @IBOutlet weak var frameChooser: UICollectionView!
    @IBOutlet weak var frameNumberLabel: UILabel!
    @IBOutlet weak var switchState: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameChooser.backgroundColor = UIColor.whiteColor();
        self.frameChooser.dataSource = self;
        self.frameChooser.delegate = self;
        self.imagePicker.delegate = self;
        
        if let label = data {
            switchState.text = data
        }
        if (data == "Off") {
            looping = 1;
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
        currentSelectedCell = indexPath.row;
        
        //this opens photo library
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        NSLog(String(currentSelectedCell))
        images[currentSelectedCell] = (info[UIImagePickerControllerOriginalImage] as? UIImage)!;
        self.dismissViewControllerAnimated(true, completion: {})
        frameChooser.reloadData()
        NSLog(String(images.count))
        for(var i = 0;i<images.count; i++) {
            NSLog(String(i))
            if images[i] as! NSObject != 0 {
                NSLog(images[i].description as String)
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        NSLog("cancelled")
        self.imagePicker = UIImagePickerController()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createGif(sender: UIButton) {
        
        let loopCount: Int = looping
        let frameDelay: CGFloat = 1.0
        
        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: loopCount]] //set loopcount to 0 means loop forever
        let frameProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: frameDelay]] //
        
        let documentsDirectoryURL: NSURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain:.UserDomainMask, appropriateForURL:nil, create:true);
        
        let fileURL: NSURL = documentsDirectoryURL.URLByAppendingPathComponent("animated.gif");
        
        var i: Int
        var counter: Int = 0
        for (i = 0; i < frameNumber; i+=1) {
            if images[i] as! NSObject != 0 {
                counter++
            }
        }
        
        let destination: CGImageDestinationRef = CGImageDestinationCreateWithURL(fileURL, kUTTypeGIF, counter, nil)!;
        CGImageDestinationSetProperties(destination, fileProperties);
        
        for (i = 0; i < frameNumber; i+=1) {
            if images[i] as! NSObject != 0 {
                CGImageDestinationAddImage(destination, images[i].CGImage!!, frameProperties);
            }
        }
        
        
        if (!CGImageDestinationFinalize(destination)) {
            NSLog("failed to finalize image destination");
        }
        else {
            NSLog("url=%@", fileURL);
            _fileURL = fileURL
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "finish") {
            (segue.destinationViewController as! FinalViewController).passed = _fileURL
        }
    }
}

