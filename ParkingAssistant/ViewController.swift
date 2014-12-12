//
//  ViewController.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 11/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationTargetLabel: UILabel!
    @IBOutlet weak var smsDetails: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func doFillInformationLabels(parkingManager: ParkingManager) {
        locationTargetLabel.text = parkingManager.getCityName()
        smsDetails.text = parkingManager.getSmsDetails()
        licensePlateLabel.text = parkingManager.getLicensePlate()

    }
    
    
    @IBAction func getUserLocation(sender: UIButton) {
        let parkingManager = ParkingManager()
        self.doFillInformationLabels(parkingManager)
        
        var success = parkingManager.doBuyParkingPermit()
        
        successLabel.hidden = success
        errorLabel.hidden = !success
    }

}

