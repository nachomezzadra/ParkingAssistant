//
//  ViewController.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 11/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import UIKit
import CoreLocation

class ViewControllerOld: UIViewController {
    //, CLLocationManagerDelegate {
    
    //    let locationManager = CLLocationManager()
    var manager: OneShotLocationManager?
    var currentLocation: CurrentLocation = CurrentLocationAuto()
    
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
    
    
    @IBAction func doPark(sender: AnyObject) {
        let parkingManager = ParkingManager(currentLocation: self.currentLocation)
        //var currentCity =
        self.doFillInformationLabels(parkingManager)
        
        var success = parkingManager.doBuyParkingPermit()
        
        successLabel.hidden = success
        errorLabel.hidden = !success
    }
    
    @IBAction func findCurrentLocation(sender: AnyObject) {
        
        var currentCity = self.currentLocation.getCurrentCity().name
        self.locationTargetLabel.text = currentCity
        
        //
        // request the current location
        //
        /*        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
        
        // fetch location or an error
        if let loc = location {
        //self.label.text = loc.description
        self.locationTargetLabel.text = loc.locality
        } else if let err = error {
        //self.label.text = err.localizedDescription
        self.locationTargetLabel.text = err.localizedDescription
        
        }
        
        // destroy the object immediately to save memory
        self.manager = nil
        }
        */
        
        
        //locationManager.delegate = self
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.startUpdatingLocation()
        
    }
    
    
    /*
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
    
    if (error != nil) {
    println("Reverse geocoder failed with error" + error.localizedDescription)
    return
    }
    
    if placemarks.count > 0 {
    let pm = placemarks[0] as CLPlacemark
    self.displayLocationInfo(pm)
    } else {
    println("Problem with the data received from geocoder")
    }
    })
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
    if let containsPlacemark = placemark {
    //stop updating location to save battery life
    locationManager.stopUpdatingLocation()
    let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
    let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
    let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
    let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
    println(locality)
    let street = containsPlacemark.thoroughfare
    let streetNumber = containsPlacemark.subThoroughfare
    println(street)
    println(streetNumber)
    self.locationTargetLabel.text = locality
    println(postalCode)
    println(administrativeArea)
    println(country)
    }
    
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    println("Error while updating location " + error.localizedDescription)
    }
    */
}

