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
    
    enum Operations: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operations.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var resultValStr = ""

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
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
        
    }
    @IBAction func onDividePress(sender: AnyObject) {
        processedOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPress(sender: AnyObject) {
        processedOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPress(sender: AnyObject) {
        processedOperation(operation: .Subtract)
    }
    @IBAction func onAddPress(sender: AnyObject) {
        processedOperation(operation: .Add)
    }
    @IBAction func onEqualPress(sender: AnyObject) {
        processedOperation(operation: currentOperation)
        
        //Allows a new computation to be entered but disallows the continuation of the current computation
//        currentOperation = Operations.Empty
    }
    func processedOperation(operation: Operations) {
        playSound()
        
        if currentOperation != Operations.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operations.Divide {
                    resultValStr = "\(Int(leftValStr)! / Int(rightValStr)!)"
                    
                }else if currentOperation == Operations.Multiply {
                    resultValStr = "\(Int(leftValStr)! * Int(rightValStr)!)"
                    
                }else if currentOperation == Operations.Add {
                    resultValStr = "\(Int(leftValStr)! + Int(rightValStr)!)"
                    
                }else if currentOperation == Operations.Subtract {
                    resultValStr = "\(Int(leftValStr)! - Int(rightValStr)!)"
                }
                
                leftValStr = resultValStr
                outputLabel.text = resultValStr
            }
            
            currentOperation = operation
         
         //This runs the first time a number is pressed and currentOperation is Empty
        }else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
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
    
    
//    var currentNumber = ""
//    var leftSideNumber = ""
//    var rightSideNumber = ""
//    var results = ""
//    var operatorSymbol: Int?
    
    
//    @IBAction func numberPressed(sender: UIButton) {
//        playSound()
//        if operatorSymbol != nil {
//            currentNumber += "\(sender.tag)"
//            outputLabel.text = currentNumber
//            rightSideNumber = currentNumber
//        }else {
//            currentNumber += "\(sender.tag)"
//            outputLabel.text = currentNumber
//            leftSideNumber = currentNumber
//        }
//        if leftSideNumber != "" && rightSideNumber != "" {
//            if operatorSymbol == 0 {
//                results = String(Int(leftSideNumber)! / Int(rightSideNumber)!)
//            }else if operatorSymbol == 1 {
//                results = String(Int(leftSideNumber)! * Int(rightSideNumber)!)
//            }else if operatorSymbol == 2 {
//                results = String(Int(leftSideNumber)! - Int(rightSideNumber)!)
//            }else if operatorSymbol == 3 {
//                results = String(Int(leftSideNumber)! + Int(rightSideNumber)!)
//            }
//        }
//    }
    
    
//    @IBAction func operations(sender: UIButton) {
//        if leftSideNumber != "" {
//            operatorSymbol = sender.tag
//            if results != "" {
//                leftSideNumber = results
//                outputLabel.text = leftSideNumber
//                currentNumber = ""
//                rightSideNumber = ""
//            }else {
//                outputLabel.text = leftSideNumber
//                leftSideNumber += results
//                currentNumber = ""
//                rightSideNumber = ""
//            }
//        }
//    }
    
    
//    @IBAction func equals(_ sender: Any) {
//        if results != "" {
//            outputLabel.text = results
//            operatorSymbol = nil
//            leftSideNumber = outputLabel.text!
//            rightSideNumber = ""
//            results = ""
//            currentNumber = ""
//        }
//    }


}

