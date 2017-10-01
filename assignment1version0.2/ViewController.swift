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
    
    var systemIsMetric:Bool = true;
    
    var diameterIsInYards:Bool = true;
    
    var distanceIsInYards:Bool = true;

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var totalRevolutionsTB: UITextField!
    
    @IBOutlet weak var timeTB: UITextField!
    
    @IBOutlet weak var wheelDiameterTB: UITextField!
    
    @IBOutlet weak var rpmTB: UITextField!

    @IBOutlet weak var targetDistanceTB: UITextField!
    
    @IBOutlet weak var diameterChangeButton: UIButton!
    
    @IBOutlet weak var distanceChangeButton: UIButton!
    
    @IBOutlet weak var conversionSystemButton: UIButton!
    
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
            
            var validation = validateInput();
            
        }
        
    }
    
    //func co
    
    func validateInput() -> Bool
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
            totalRevolutionsTB.text = "";
            timeTB.text = ""
            diameterDouble = nil;
            rpmDouble = nil;
            targetDistanceDouble = nil;
            return false;
            // break and redo
        }
        else // input is validated
        {
            errorLabel.isHidden = true;
            diameterDouble = Double(diameterText!);
            rpmDouble = Double(rpmText!);
            targetDistanceDouble = Double(targetDistanceText!);
            timeTB.backgroundColor = UIColor.lightText;
            totalRevolutionsTB.backgroundColor = UIColor.lightText;
            return true;
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
        
        print("DIAMETER DOUBLE IS \(diameterDouble)");
        if (diameterDouble == nil || rpmDouble == nil || targetDistanceDouble == nil)
        {
            print("ERROR INPUT HERE");
            // erroneous input
        }
        else // input is all good
        {
            timeTB.backgroundColor = UIColor.lightText;
            totalRevolutionsTB.backgroundColor = UIColor.lightText;
            errorLabel.isHidden = true;
            
            var bothDiameterAndDistanceSameUnit:Bool = true;
            
            if(!systemIsMetric) // system is imperial
            {
                if (diameterIsInYards)
                {
                    if(distanceIsInYards) // both in yards
                    {
                        print("distance double = \(targetDistanceDouble!) + diameter double = \(diameterDouble!)");
                        
                    }
                    else // diameter yards, distance feet
                    {
                        bothDiameterAndDistanceSameUnit = false;
                        
                        // convert diameter to feet
                        // 
                        print("\n DIAMETER UNIT TEXT \(diameterUnit.text) \n DISTANCE UNIT TEXT \(distanceUnit.text) \n")
                        targetDistanceDouble = targetDistanceDouble! / 3;
                        print("distance double = \(targetDistanceDouble!) + diameter double = \(diameterDouble!)");
                        bothDiameterAndDistanceSameUnit = true;
                    }
                }
                else // diameter is not in yards
                {
                    if(distanceIsInYards) // diameter feet, distance yards
                    {
                        // 1 yard is 3 feet
                        print("\n DIAMETER UNIT TEXT \(diameterUnit.text) \n DISTANCE UNIT TEXT \(distanceUnit.text) \n")
                        diameterDouble = diameterDouble! / 3;
                        print("distance double = \(targetDistanceDouble!) + diameter double = \(diameterDouble!)");
                        bothDiameterAndDistanceSameUnit = true;
                    }
                    else // distance, diameter feet
                    {
                        print("distance double = \(targetDistanceDouble!) + diameter double = \(diameterDouble!)");
                    }
                }
            }
            else // system is metric
            {
                
                
                if (diameterIsInMetres)
                {
                    // both diameter and distance are in metres -> will return time in seconds
                    if (distanceIsInMetres)
                    {
                        
                    }
                    else // diameter is only in metres distance is in mm
                    {
                        bothDiameterAndDistanceSameUnit = false;
                        
                        // diameter = m
                        // distance = mm
                        // convert diameter to mm
                        diameterDouble = diameterDouble! * 1000;
                        print("distance double = \(targetDistanceDouble!) + diameter double = \(diameterDouble!)");
                        bothDiameterAndDistanceSameUnit = true;
                        
                    }
                }
                else // diameter isn't in metres
                {
                    if (distanceIsInMetres) // distance is in metres but diameter isn't
                    {
                        bothDiameterAndDistanceSameUnit = false;
                        
                        // diameter is in mm, distance in m
                        // convert distance to mm
                        targetDistanceDouble = targetDistanceDouble! * 1000;
                        print("distance double = \(targetDistanceDouble!) + diameter double = \(diameterDouble!)");
                        bothDiameterAndDistanceSameUnit = true;
                    }
                    else // both diameter and distance are not in metres -> will return time in seconds
                    {
                        
                    }
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
        if (!systemIsMetric) // imperial - convert to foot or yard
        {
            print("system is imperial");
            
            if (diameterIsInYards) // convert to feet
            {
                diameterUnit.text = "FT";
                diameterChangeButton.setTitle("Change to Y", for: .normal);
                diameterIsInYards = false;
            }
            else // convert back to yards
            {
                diameterUnit.text = "Y";
                diameterChangeButton.setTitle("Change to FT", for: .normal);
                diameterIsInYards = true;
            }
        }
        else
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
        
    }
    
    
    
    @IBAction func distanceChange(_ sender: Any)
    {
        
        if(!systemIsMetric) // imperial - convert to foot or yard
        {
            if (distanceIsInYards) // convert to feet
            {
                distanceUnit.text = "FT";
                distanceChangeButton.setTitle("Change to Y", for: .normal);
                distanceIsInYards = false;
            }
            else // convert back to yards
            {
                distanceUnit.text = "Y";
                distanceChangeButton.setTitle("Change to FT", for: .normal);
                distanceIsInYards = true;
            }
        }
        else
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
        
    }
    
    
    @IBAction func convertSystem(_ sender: Any)
    {
        // validate first
        
        
        if (validateInput())
        {
            // valid input
        }
        else // invalid input, return button
        {
            print("Error: Input is not valid");
            return;
        }
        
        var diameterSystemConvert = Double(wheelDiameterTB.text!);
        
        var distanceSystemConvert = Double(targetDistanceTB.text!);
        
        var diameterDoubleConvert = diameterSystemConvert;
        
        var distanceDoubleConvert = distanceSystemConvert;
        
        if (systemIsMetric) // convert to imperial
        {
            
            // check the current unit and convert to yards
            if (distanceIsInMetres)
            {
                
                // convert distance to yards
                // 1 yard = 0.9144 metres
                // 1 yard = 914.4 millimetres
                
                distanceDoubleConvert = distanceDoubleConvert! * 0.91440275783872;
                
                if (diameterIsInMetres) // distance, diameter M
                {
                    diameterDoubleConvert = diameterDoubleConvert! * 0.91440275783872;
                }
                else // distance M, diameter MM
                {
                    diameterDoubleConvert = diameterDoubleConvert! * 914.4;
                }
                
            }
            else // distance is in MM
            {
                print("Distance is in MM");
                
                distanceDoubleConvert = distanceDoubleConvert! * 914.4;
                
                if (diameterIsInMetres) // distance MM, diameter M
                {
                    diameterDoubleConvert = diameterDoubleConvert! * 0.91440275783872;
                }
                else // distance MM, diameter MM
                {
                    diameterDoubleConvert = diameterDoubleConvert! * 914.4;
                }
            }
            
            targetDistanceTB.text = String(distanceDoubleConvert!);
            wheelDiameterTB.text = String(diameterDoubleConvert!);
            
            conversionSystemButton.setTitle("Convert to Metric", for: .normal);
            diameterUnit.text = "Y";
            distanceUnit.text = "Y";
            diameterChangeButton.setTitle("Change to FT", for: .normal)
            distanceChangeButton.setTitle("Change to FT", for: .normal)
            
            distanceIsInYards = true;
            diameterIsInYards = true;
            
            systemIsMetric = false;
            print("Unit Measurement System has now been changed to Imperial");
        }
        else // convert back to metric
        {
            if (distanceIsInYards)
            {
                // convert distance to metres
                // 1 metre = 1.09361 yards
                // 1 metre = 3.28084 feet
                
                distanceDoubleConvert = distanceDoubleConvert! * 1.0936132983371;
                
                if (diameterIsInYards) // distance, diameter in yards
                {
                    diameterDoubleConvert = diameterDoubleConvert! * 1.0936132983371;
                }
                else // distance yards, diameter ft
                {
                    diameterDoubleConvert = diameterDoubleConvert! * 3.28084;
                }
            }
            else
            {
                distanceDoubleConvert = distanceDoubleConvert! * 3.28084;
                
                if (diameterIsInYards) // distance ft, diameter yard
                {
                    diameterDoubleConvert = diameterDoubleConvert! * 1.0936132983371;
                }
                else // distance, diameter ft
                {
                    diameterDoubleConvert = diameterDoubleConvert! * 3.28084;
                }
            }
            
            
            targetDistanceTB.text = String(distanceDoubleConvert!);
            wheelDiameterTB.text = String(diameterDoubleConvert!);
            
            conversionSystemButton.setTitle("Convert to Imperial", for: .normal);
            diameterUnit.text = "M";
            distanceUnit.text = "M";
            diameterChangeButton.setTitle("Change to MM", for: .normal)
            distanceChangeButton.setTitle("Change to MM", for: .normal)
            
            systemIsMetric = true;
            print("Unit Measurement System has now been changed to Metric");
            
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

