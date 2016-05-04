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
//import AVFoundation

class SecondViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate {
    
    //var gif = NSURL(fileURLWithPath: "/Users/Lucifer/Desktop/giff.m4a")
    //var audioPlayer = AVAudioPlayer()

    
    // figures out the loop information
    var data: String?
    // number of frames
    var frameNumber: Int = 0
    // images to save into an array
    var images : NSMutableArray = []
    
    
    // variable that chooses the images that are set
    var imagePicker = UIImagePickerController()
    // no current selected cell off the start, user selects
    var currentSelectedCell = -1;
    // check for looping
    var looping = 0;
    // url of the gif
    var _fileURL:NSURL?
    var _logoURL:NSURL?
    
    
    
    // amount of delay between frames
    var delay: Float?
    // switching the number of frames
    var oldValue: Double = 0.0;

    // frame incrementer and decrementer
    @IBOutlet weak var stepper: UIStepper!
    // choose the frame
    @IBOutlet weak var frameChooser: UICollectionView!
    // label the frames with their numbers
    @IBOutlet weak var frameNumberLabel: UILabel!
    // labels for stating if looping is enabled
    @IBOutlet weak var loopingSwitch: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //audioPlayer = AVAudioPlayer(contentsOfURL: gif, fileTypeHint: nil)
        //audioPlayer.prepareToPlay()
        // set the frame incrementer and decrementer to its value
        oldValue=stepper.value;
        
        //make the frames white and initialize them
        frameChooser.backgroundColor = UIColor.whiteColor();
        self.frameChooser.dataSource = self;
        self.frameChooser.delegate = self;
        self.imagePicker.delegate = self;
        
        //if let label = data {
        //determine looping
        //switchState.text = data
        loopingSwitch.text = data;
        //}
        if (data == "Off") {
            looping = 1;
        }
        else{
            looping=0;
        }
        
        //state the number of frames
        frameNumberLabel.text = String(frameNumber)
        
        //reload the data
        frameChooser.reloadData()
        //initializes images[] with null values (0's) so that images can be swapped with the different frames out of order.
        //make the image objects for the number of frames your have
        
        
  
        var i:Int
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
        cell.layer.backgroundColor = UIColor.whiteColor().CGColor

        
        //this shows how this function loops through each cell:
        cell.label.text = String(indexPath.item + 1)
        
        
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
        NSLog("media")
        
        //having the image assigned to the image picked and reloaded
        images[currentSelectedCell] = (info[UIImagePickerControllerOriginalImage] as? UIImage)!;
        self.dismissViewControllerAnimated(true, completion: {})
        frameChooser.reloadData()
        NSLog(String(images.count))
    }
    
    // see if the action is canceled
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        NSLog("cancelled")
        self.imagePicker = UIImagePickerController()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // having the frame number changed if incremented or decremented
    @IBAction func stepper(sender: UIStepper, forEvent event: UIEvent) {
        
        if (stepper.value>oldValue) {
            oldValue=oldValue+1;
            //Your Code You Wanted To Perform On Increment

            frameNumber+=1
            //images.addObject(0);
            
        }
            
        else {
            oldValue=oldValue-1;
            //Your Code You Wanted To Perform On Decrement
     
            if (frameNumber>0){
                frameNumber-=1
                //images.removeObjectAtIndex(images.count-1)
            }
        }
        
        //frameChooser.reloadData()
        viewDidLoad()
        //NSLog("%d",oldValue);
        
    }

    
@IBAction func createGif(sender: UIButton) {
        //audioPlayer.play()
   
        //let frameCount: Int = frameNumber
    
        // counts the number of non nil frames to count number of pictures
        var i: Int
        var numberOfPics:Int=0;
        for (i = 0; i < frameNumber; i+=1) {
            
            if (images.objectAtIndex(i) as! NSObject != 0){
                numberOfPics++;

            }
        }
    
        // have the loop count be the number of pictures
        let loopCount: Int = numberOfPics
        // frame delay will be determined by delay divided by 10 (0.0-1.0)
        let frameDelay: Float = delay!/10.0
    
        NSLog("%f",frameDelay);
    
        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: loopCount]] //set loopcount to 0 means loop forever
        let frameProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: frameDelay]] //
        
        let documentsDirectoryURL: NSURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain:.UserDomainMask, appropriateForURL:nil, create:true);
        
        let fileURL: NSURL = documentsDirectoryURL.URLByAppendingPathComponent("animated.gif");
        
  
        // counts the number of non empty images
        var counter: Int = 0
        for (i = 0; i < frameNumber; i+=1) {
            if images[i] as! NSObject != 0 {
                counter++
            }
        }
    
        // creates a gif reference destination to be assigned file properties
        let destination: CGImageDestinationRef = CGImageDestinationCreateWithURL(fileURL, kUTTypeGIF, counter, nil)!;
        CGImageDestinationSetProperties(destination, fileProperties);
    
        // make all the non empty images in the destination
        for (i = 0; i < frameNumber; i+=1) {
            if images[i] as! NSObject != 0 {
                CGImageDestinationAddImage(destination, images[i].CGImage!!, frameProperties);
            }
        }
        
        // make sure it is not null
        if (!CGImageDestinationFinalize(destination)) {
            NSLog("failed to finalize image destination");
        }
        // print the url and assign it to itself
        else {
            NSLog("url=%@", fileURL);
            _fileURL = fileURL

        }
    

        
    }
    
    // have the value passed be given as the file url gif
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "finish") {
            (segue.destinationViewController as! FinalViewController).passed = _fileURL
    
        }
    }
    

}

