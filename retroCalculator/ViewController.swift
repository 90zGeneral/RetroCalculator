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
    
    //To display the current computation
    @IBOutlet var outputLabel: UILabel!
    
    //Represents 
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
    
    //Call the playSound method each time a number is pressed
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        //Append each number pressed to the left side of the equation and update the output label
        currentNumber += "\(sender.tag)"
        outputLabel.text = currentNumber
        leftSideNumber = currentNumber
        rightSideNumber = leftSideNumber
        
    }
    
    //
    @IBAction func operationsAndEqualBtn(sender: UIButton) {
        if currentNumber != "" {
            currentNumber = ""
            operatorSymbol = sender.tag
        }
    }
    
    func calculation(left: String, right: String) -> Int {
        
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

