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

    var data: NSData?
    var passed:NSURL?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        data = NSData(contentsOfURL:passed!)
        NSLog(passed!.lastPathComponent!)
        if passed != nil {
            finalGif?.image = UIImage.animatedImageWithAnimatedGIFURL(passed)
                //UIImage(data:data!)
//            UIImageWriteToSavedPhotosAlbum(UIImage.animatedImageWithAnimatedGIFURL(passed), nil, nil, nil);
            let image = NSData(contentsOfURL: passed!)
            
            ALAssetsLibrary().writeImageDataToSavedPhotosAlbum(image, metadata: nil, completionBlock: { (assetURL: NSURL!, error: NSError!) -> Void in
                print(assetURL)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
