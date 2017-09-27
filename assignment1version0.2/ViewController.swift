//
//  ViewController.swift
//  assignment1version0.2
//
//  Created by Anfiteatro, Gianni - anfgy001 on 21/9/17.
//  Copyright © 2017 Anfiteatro, Gianni - anfgy001. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var timeTB: UITextField!
    
    @IBOutlet weak var wheelDiameterTB: UITextField!
    
    @IBOutlet weak var rpmTB: UITextField!

    @IBOutlet weak var targetDistanceTB: UITextField!
    
    var diameterDouble:Double?;
    
    var rpmDouble:Double?;
    
    var targetDistanceDouble:Double?
    
    // NOTE: Conversions from .text to Double? WORK
    
    /*
        The main function of loading the view from the view controller
        Sets the default values for the text fields (to 1)
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //displayAlert(userMessage: "test");
        wheelDiameterTB.text = "1";
        rpmTB.text = "1";
        targetDistanceTB.text = "1";
        errorLabel.isHidden = true;
    }
    
    
    /*
    
        Converts the text to optional string to deal with exceptions (no input) 
        Changes to double to deal with values with decimals
     */
    func convertInputToDouble()
    {
        
        //NOTE: Doesn't handle empty input!!!
        
        if (wheelDiameterTB.text == "")
        {
            print("There is no wheel diameter!");
            // break
        }
        else if (rpmTB.text == "")
        {
            print("There is no rpm!");
            // break
        }
        else if (targetDistanceTB.text == "")
        {
            print("There is no target distance!");
            // break
        }
        else
        {
            
            let diameterText:String? = wheelDiameterTB.text;
            let rpmText:String? = rpmTB.text;
            let targetDistanceText:String? = targetDistanceTB.text;
            
            let diameterConversion = Double(diameterText!);
            let rpmConversion = Double(rpmText!);
            let targetDistanceConversion = Double(targetDistanceText!);
            
            
            if (diameterConversion == nil || rpmConversion == nil || targetDistanceConversion == nil)
            {
                print("invalid number");
                errorLabel.isHidden = false;
                timeTB.backgroundColor = UIColor.red; //TODO: Test this
                // break and redo
            }
            else
            {
                diameterDouble = Double(diameterText!)!;
                rpmDouble = Double(rpmText!)!;
                targetDistanceDouble = Double(targetDistanceText!)!;
            }
            
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    /* NOT NEEDED
    
    func displayAlert(userMessage: String)
    {
        _ = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert);
    }
 
 */
    
    // button function
    /*
     
     Action for button to calculate time given the double values of the inputs
     
     
     */
    @IBAction func calculateTime(_ sender: UIButton)
    {
        
    
        convertInputToDouble();
        print("clicked" + "\n");
        
        // doubles are nil when they don't work
        // DO NOT CONVERT
        
        if (diameterDouble == nil || rpmDouble == nil || targetDistanceDouble == nil)
        {
            timeTB.text = "";
            // erroneous input
        }
        else
        {
            let theTime:Double? = timeCalculation(diameter: diameterDouble!, rpm: rpmDouble!, distance: targetDistanceDouble!);
            
            print(theTime!);
            
            let timeString = String(describing: theTime);
            
            timeTB.text = timeString;
        }
        
        
    }
    
    /*
     
     Chose to have multiple variables instead of a sole variable with calculations 
     to make sure that even if the language isn't strongly typed, coupled etc that 
     the correct calculations will be shown also to deal with order of precedence
     
     */
    func timeCalculation(diameter: Double, rpm: Double, distance: Double) -> Double
    {
        // Time = Distance / ((pi * Diameter) / 60) * RPM)
        let pi = M_PI;
        
        let piTimesDiameter = pi * diameter;
        let piTimesDiameterAllDividedBy60 = piTimesDiameter / 60;
        
        let time = distance / (piTimesDiameterAllDividedBy60 * rpm);
        
        return time;
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

