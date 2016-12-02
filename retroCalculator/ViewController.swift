//
//  ViewController.swift
//  retroCalculator
//
//  Created by Roydon Jeffrey on 11/28/16.
//  Copyright © 2016 Italyte. All rights reserved.
//

import UIKit
import AVFoundation      //This framework gives access to the AVAudioPlayer and its methods

class ViewController: UIViewController {
    
    //To store the audio player in a variable
    var btnSound: AVAudioPlayer!
    
    @IBOutlet var outputLabel: UILabel!
    
    var currentNumber = ""
    var leftSideNumber = ""
    var rightSideNumber = ""
    var results = ""
    var operatorSymbol: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        outputLabel.text = "0"
        
        //Grab the path of the sound stored in the app on the user's device in the Bundle and create a file path with a URL
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        //Prepare the sound to play and throw an error message if unsuccessful
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        if operatorSymbol != nil {
            currentNumber += "\(sender.tag)"
            outputLabel.text = currentNumber
            rightSideNumber = currentNumber
        }else {
            currentNumber += "\(sender.tag)"
            outputLabel.text = currentNumber
            leftSideNumber = currentNumber
        }
        if leftSideNumber != "" && rightSideNumber != "" {
            if operatorSymbol == 0 {
                results = String(Int(leftSideNumber)! / Int(rightSideNumber)!)
            }else if operatorSymbol == 1 {
                results = String(Int(leftSideNumber)! * Int(rightSideNumber)!)
            }else if operatorSymbol == 2 {
                results = String(Int(leftSideNumber)! - Int(rightSideNumber)!)
            }else if operatorSymbol == 3 {
                results = String(Int(leftSideNumber)! + Int(rightSideNumber)!)
            }
        }
    }
    @IBAction func operations(sender: UIButton) {
        if leftSideNumber != "" {
            operatorSymbol = sender.tag
            if results != "" {
                leftSideNumber = results
                outputLabel.text = leftSideNumber
                currentNumber = ""
                rightSideNumber = ""
            }else {
                outputLabel.text = leftSideNumber
                leftSideNumber += results
                currentNumber = ""
                rightSideNumber = ""
            }
        }
    }
    @IBAction func equals(_ sender: Any) {
        if results != "" {
            outputLabel.text = results
            operatorSymbol = nil
            leftSideNumber = outputLabel.text!
            rightSideNumber = ""
            results = ""
            currentNumber = ""
        }
    }
    
    //Check whether sound is playing and play it if it's not
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }else {
            btnSound.play()
        }
    }


}

