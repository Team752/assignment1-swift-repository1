//
//  ViewController.swift
//  assignment1version0.2
//
//  Created by Anfiteatro, Gianni - anfgy001 on 21/9/17.
//  Copyright © 2017 Anfiteatro, Gianni - anfgy001. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var diameterIsInMetres:Bool = true;
    
    var distanceIsInMetres:Bool = true;

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var totalRevolutionsTB: UITextField!
    
    @IBOutlet weak var timeTB: UITextField!
    
    @IBOutlet weak var wheelDiameterTB: UITextField!
    
    @IBOutlet weak var rpmTB: UITextField!

    @IBOutlet weak var targetDistanceTB: UITextField!
    
    @IBOutlet weak var diameterChangeButton: UIButton!
    
    @IBOutlet weak var distanceChangeButton: UIButton!
    
    @IBOutlet weak var diameterUnit: UILabel!

    @IBOutlet weak var distanceUnit: UILabel!
    
    var diameterDouble:Double?;
    
    var rpmDouble:Double?;
    
    var targetDistanceDouble:Double?
    
    var timeString:String = "";
    
    var wheelDiameterUnit:String = "";
    
    var TargetDistanceUnit:String = "";
    
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
                print("\n \n invalid number \n \n");
                errorLabel.isHidden = false;
                timeTB.backgroundColor = UIColor.red;
                totalRevolutionsTB.backgroundColor = UIColor.red;
                // break and redo
            }
            else
            {
                print("\n DIAMETER TEXT IS \(diameterText)");
                diameterDouble = Double(diameterText!);
                rpmDouble = Double(rpmText!);
                targetDistanceDouble = Double(targetDistanceText!);
            }
        }
        
    }
    
    
    
    // button function
    /*
     
     Action for button to calculate time given the double values of the inputs
     The type of units distance and diameter have are determined here after user input validation for performance purposes
     
     
     */
    @IBAction func calculateTime(_ sender: UIButton)
    {
        
    
        convertInputToDouble();
        
        if (diameterDouble == nil || rpmDouble == nil || targetDistanceDouble == nil)
        {
            timeTB.text = "";
            // erroneous input
        }
        else // input is all good
        {
            timeTB.backgroundColor = UIColor.lightText;
            totalRevolutionsTB.backgroundColor = UIColor.lightText;
            errorLabel.isHidden = true;
            
            var bothDiameterAndDistanceSameUnit:Bool = true;
            
            if (diameterIsInMetres)
            {
                // both diameter and distance are in metres -> will return time in seconds
                if (distanceIsInMetres)
                {
                    
                }
                else // diameter is only in metres
                {
                    bothDiameterAndDistanceSameUnit = false;
                }
            }
            else // diameter isn't in metres
            {
                if (distanceIsInMetres) // distance is in metres but diameter isn't
                {
                    bothDiameterAndDistanceSameUnit = false;
                }
                else // both diameter and distance are not in metres -> will return time in seconds
                {
                    
                }
            }
            
            if (bothDiameterAndDistanceSameUnit)
            {
                let theTime = timeCalculation(diameter: diameterDouble!, rpm: rpmDouble!, distance: targetDistanceDouble!);
                
                timeString = String(theTime);
                
                timeTB.text = timeString;
                
                let totalRevs = totalRevolutionsCalculation(rpm: rpmDouble!, timeInMs:theTime);
                
                let revsString = String(totalRevs);
                
                totalRevolutionsTB.text = revsString;
            }
        
            // IDEA: ROUND THE RESULT, IMPLEMENT LATER ON....
        }
        
        
        
        diameterDouble = nil;
        rpmDouble = nil;
        targetDistanceDouble = nil;
        
    }
    
    @IBAction func diameterChange(_ sender: UIButton)
    {
        if (diameterIsInMetres)
        {
            diameterUnit.text = "MM";
            diameterChangeButton.setTitle("Change to M", for: .normal);
            diameterIsInMetres = false;
        }
        else
        {
            diameterUnit.text = "M";
            diameterChangeButton.setTitle("Change to MM", for: .normal);
            diameterIsInMetres = true;
        }
    }
    
    
    
    @IBAction func distanceChange(_ sender: Any)
    {
        if (distanceIsInMetres)
        {
            distanceUnit.text = "MM";
            distanceChangeButton.setTitle("Change to M", for: .normal);
            distanceIsInMetres = false;
        }
        else
        {
            distanceUnit.text = "M";
            distanceChangeButton.setTitle("Change to MM", for: .normal);
            distanceIsInMetres = true;
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
        
        var time = distance / (piTimesDiameterAllDividedBy60 * rpm);
        
        // calculating to MS here, will need to be edited later on
        time = time * 1000;
        
        return time;
    }
    
    /*
 
     Decided to scale up instead of down for performance purposes, 
     using larger numbers would take more of a performance hit
     
    */
    func totalRevolutionsCalculation(rpm: Double, timeInMs: Double) -> Double
    {
        
        let timeInSeconds = timeInMs / 1000;
        let timeInMinutes = timeInSeconds / 60;
        
        let finalRevolutions = rpm * timeInMinutes;
        
        return finalRevolutions;
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

