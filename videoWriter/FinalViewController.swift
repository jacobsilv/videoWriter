//
//  FinalViewController.swift
//  videoWriter
//
//  Created by Anthony Salazar on 5/1/16.
//  Copyright (c) 2016 nyu.edu. All rights reserved.
//

import UIKit
import AssetsLibrary


class FinalViewController: UIViewController {
    @IBOutlet weak var finalGif: UIImageView!
    

    
  
    var passed:NSURL?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        data = NSData(contentsOfURL:passed!)
      
        
        // make sure that the value passed is not null
        if passed != nil {
            
            // print the path of the url for the gif
            NSLog(passed!.lastPathComponent!)
            
            // animate the url gif
            finalGif?.image = UIImage.animatedImageWithAnimatedGIFURL(passed)
            
        }
      
      
            
    
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // have the save button
    @IBOutlet weak var save: UIButton!
    @IBAction func saveGif(sender: UIButton) {
        
        // make sure the url is not nil
        if passed != nil {
        
            
            // saves the url gif as image
            let image = NSData(contentsOfURL: passed!)
            
            
            // write image to the picture library
            ALAssetsLibrary().writeImageDataToSavedPhotosAlbum(image, metadata: nil, completionBlock: { (assetURL: NSURL!, error: NSError!) -> Void in
                print(assetURL, terminator: "")
            })
        }
    }

}
    
    
    

        

    
    


