//
//  ViewController.swift
//  assignment1version0.2
//
//  Created by Anfiteatro, Gianni - anfgy001 on 21/9/17.
//  Copyright © 2017 Anfiteatro, Gianni - anfgy001. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wheelDiameterTB: UITextField!
    
    @IBOutlet weak var rpmTB: UITextField!

    @IBOutlet weak var targetDistanceTB: UITextField!
    
    var diameterDouble:Double?;
    
    var rpmDouble:Double?;
    
    var targetDistanceDouble:Double?
    
    // need to convert text fields
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayAlert(userMessage: "test");
    }
    
   /* func calculateTime(diameter: Double, rpm: Double, distance: Double) -> Double
    {
        
        
        return 0.0;
    }   */
    
    func convertInputToDouble()
    {
        
        //NOTE: Doesn't handle empty input!!!
        let diameterText:String? = wheelDiameterTB.text;
        diameterDouble = Double(diameterText!)!;
        
        let rpmText:String? = rpmTB.text;
        rpmDouble = Double(rpmText!)!;
        
        let targetDistanceText:String? = targetDistanceTB.text;
        targetDistanceDouble = Double(targetDistanceText!)!;
    }
    
    func displayAlert(userMessage: String)
    {
        _ = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert);
    }
    
    
    
    @IBAction func calculateTime(_ sender: UIButton)
    {
    
    
        convertInputToDouble();
        displayAlert(userMessage: "test");
        print("clicked" + "\n");
        
    
    }
    
    
    func greet(person: String) {
        print("Hello, \(person)!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

