//
//  FirstViewController.swift
//  videoWriter
//
//  Created by Anthony Salazar on 4/29/16.
//  Copyright (c) 2016 nyu.edu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var frameOptions = [2,3,4,5,6,7,8,9,10,16,32]
    var selectedFrameOption : Int = 2

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderVal: UILabel!
    
    @IBOutlet weak var nswitch: UISwitch!
    
    @IBOutlet weak var framePicker: UIPickerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.framePicker.dataSource = self;
        self.framePicker.delegate = self;
    }

    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        let selectedValue = Float(sender.value)/10.0;
        
        sliderVal.text = String(format: "%.2fs", selectedValue)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "push") {
            var state:String
            if(nswitch.on) {
                state = "On"
            } else {
                state = "Off"
            }
            (segue.destinationViewController as! SecondViewController).delay = slider.value
            (segue.destinationViewController as! SecondViewController).data = state
            (segue.destinationViewController as! SecondViewController).frameNumber = selectedFrameOption
        }
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frameOptions.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return String(frameOptions[row])
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFrameOption = frameOptions[row]
        NSLog(String(selectedFrameOption))
    }
}

