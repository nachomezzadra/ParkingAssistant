//
//  ViewController.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 11/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UIPickerViewDelegate {
    
    
    @IBOutlet weak var locationTargetLabel: UILabel!
    @IBOutlet weak var smsDetails: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var smsNumber: UILabel!
    
    var currentLocation: CurrentLocation!
    let places: Places = Places()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setCurrentLocationForId(0)
    }
    
    func setCurrentLocationForId(cityId: Int) {
        var cityName = self.places.getCityFromId(cityId).name
        locationTargetLabel.text = cityName
        self.currentLocation =  CurrentLocationManual(currentCity: cityName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doFillInformationLabels(parkingManager: ParkingManager) {
        locationTargetLabel.text = parkingManager.getCityName()
        smsDetails.text = parkingManager.getSmsDetails().toString()
        licensePlateLabel.text = parkingManager.getLicensePlate()
        smsNumber.text = parkingManager.getSmsDetails().smsNumber

    }
    
    
    @IBAction func doPark(sender: AnyObject) {
        let parkingManager = ParkingManager(currentLocation: self.currentLocation)
        self.doFillInformationLabels(parkingManager)
        
        var success = parkingManager.doBuyParkingPermit()
        
        successLabel.hidden = success
        errorLabel.hidden = !success
    }
    
    @IBAction func findCurrentLocation(sender: AnyObject) {
        let myAlert = UIAlertView(title: "Current Location",
            message: "You are in " + currentLocation.getCurrentCity().name,
            delegate: nil, cancelButtonTitle: "Ok")
        myAlert.show()
    
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.places.getNumberOfCities()
    }


    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.places.getCityFromId(row).name
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setCurrentLocationForId(row)
    }

}

