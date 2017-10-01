//
//  ViewController.swift
//  assignment1version0.2
//
//  Created by Anfiteatro, Gianni - anfgy001 on 21/9/17.
//  Copyright © 2017 Anfiteatro, Gianni - anfgy001. All rights reserved.
// Uni email ID: anfgy001, Uni ID NO: 110169824
//

import UIKit

/*
 
 Many global variables are used, majority of them being UI elements on the application itself,
 Other global variables are chosen to be made global as there are uses across the application for them and while getters and setters 
 would be perhaps better coding practice, in the context of this application where some data is only used one time and is constantly being updated by the user,
 getters and setters were not implemented. Example: timeString string is always being updated each time the calculate is being pressed and is only determined by user input.

 ToString method was also not implemented as the data was not saved on any data store or data base, so a toString function need only store information already present on the screen anyway.
 HashCode methods were not needed either.
 
 Good programming practice was taken under consideration with this assignment, with carefully placed code blocks, detailed comments and also performance and reliability taken into consideration along the way.
 
 
 */
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
    
    
    
    /*
        The main function of loading the view from the view controller
        Sets the default values for the text fields (to 1)
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
    /*
     Complete user validation transferred to a single function
     Variable definitions not type explicit in declaration so that printing values would be made easier
     User validation is done by declaration of new variables based off of user input (text fields)
     and from there more variables are created to deal with converting them from String to double
     If the conversions amount to nil, indication that the variables entered were not valid and actions follow to make sure 
     that user validation is maintained
     Chose to return a boolean for conditionals as opposed to a void function as it makes it easier aswell for other functions to determine
     if user input is completely validated
    */
    func validateInput() -> Bool
    {
        let diameterText:String? = wheelDiameterTB.text;
        let rpmText:String? = rpmTB.text;
        let targetDistanceText:String? = targetDistanceTB.text;
        
        // no type declaration means when they are printed out the "Optional()" tags do not appear, saving time and performance as opposed to trimming the strings
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
    
    
    
    
    /*
     
     Action for button to calculate time given the double values of the inputs
     The type of units distance and diameter have are determined here after user input validation for performance purposes
     If the double values (diameterDouble etc) are nil equivalent of error in user validation, warning message outputted to console
     If both the distance and diameter are of the same measurement unit (whether it would be metres, millimetres for metric or yards or feet for imperial)
     then they do not need to be converted as the formula will always work so long as the distance and diameter are of the same measurement type
     If they are not of the same measurement type, as a general rule the higher unit type gets converted to the lower unit type to ensure precise computations
     At the end the global variables for diameter, distance and rpm are reset
     
     */
    @IBAction func calculateTime(_ sender: UIButton)
    {
        
    
        convertInputToDouble();
        if (diameterDouble == nil || rpmDouble == nil || targetDistanceDouble == nil)
        {
            print("ERROR: User Validation Error! Please choose real numbers!");
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
                            // Don't need to convert anything
                    }
                    else // diameter yards, distance feet
                    {
                        bothDiameterAndDistanceSameUnit = false;
                        
                        // convert diameter to feet
                        // 
                        targetDistanceDouble = targetDistanceDouble! / 3;
                        bothDiameterAndDistanceSameUnit = true;
                    }
                }
                else // diameter is not in yards
                {
                    if(distanceIsInYards) // diameter feet, distance yards
                    {
                        // 1 yard is 3 feet
                        diameterDouble = diameterDouble! / 3;
                        bothDiameterAndDistanceSameUnit = true;
                    }
                    else // distance, diameter feet
                    {
                        // No conversion needed
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
            
        }
        diameterDouble = nil;
        rpmDouble = nil;
        targetDistanceDouble = nil;
        
    }
    
    /*
    
     This will convert the diameter from one measurement unit to another, for metric, it will convert metres to millimetres and vice versa
     for imperial it will convert feet to yards and vice versa
     
    */
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
    
    
    /*
     
     This will convert the distance from one measurement unit to another, for metric, it will convert metres to millimetres and vice versa
     for imperial it will convert feet to yards and vice versa
     
     */
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
    
    /*
     
     User validation happens before the system is converted.
     local variables are kept for abstraction purposes and to keep data consistency
     once again, variables are kept abstract from type specific definitions to avoid printing inconsistencies to save time and improve performance
     Conversions are done by multiplying the local variables and trasferring them
     
    
    */
    @IBAction func convertSystem(_ sender: Any)
    {
        // validate first
        print("Attempting to convert system...");
        
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
            metricUpdate();
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
            
            imperialUpdate();
            
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
     using larger numbers would take more of a performance hit and also to ensure computations are correct
     
    */
    func totalRevolutionsCalculation(rpm: Double, timeInMs: Double) -> Double
    {
        
        let timeInSeconds = timeInMs / 1000;
        let timeInMinutes = timeInSeconds / 60;
        
        let finalRevolutions = rpm * timeInMinutes;
        
        return finalRevolutions;
    }
    
    /*
 
     Checking the UILabels to determine what unit measurement the metric system is on and update changes within system
     This is called specifically only when it is guaranteed that the system is already using the metric system
 
    */
    func metricUpdate()
    {
        if (diameterUnit.text == "M")
        {
            diameterIsInMetres = true;
        }
        else
        {
            diameterIsInMetres = false;
        }
        
        if (distanceUnit.text == "M")
        {
            distanceIsInMetres = true;
        }
        else
        {
            distanceIsInMetres = false;
        }
    }
    
    /*
     
     Checking the UILabels to determine what unit measurement the imperial system is on and update changes within system
     This is called specifically only when it is guaranteed that the system is already using the imperial system
     
     */
    func imperialUpdate()
    {
        if (diameterUnit.text == "Y")
        {
            diameterIsInYards = true;
        }
        else
        {
            diameterIsInYards = false;
        }
        
        if (distanceUnit.text == "Y")
        {
            distanceIsInYards = true;
        }
        else
        {
            distanceIsInYards = false;
        }
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

