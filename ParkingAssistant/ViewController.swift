//
//  ViewController.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 11/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI

class ViewController: UIViewController, UIPickerViewDelegate, MFMessageComposeViewControllerDelegate {
    
    
    @IBOutlet weak var locationTargetLabel: UILabel!
    @IBOutlet weak var smsDetails: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var smsNumber: UILabel!
    
    var currentLocation: CurrentLocation!
    let places: Places = Places()
    let smsSender = SmsSender()
   
    
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
        smsDetails.text = parkingManager.getStartSmsDetails().toString()
        licensePlateLabel.text = parkingManager.getLicensePlate()
        smsNumber.text = parkingManager.getStartSmsDetails().smsNumber
    }
    
    
    @IBAction func doPark(sender: AnyObject) {
        let parkingManager = ParkingManager(currentLocation: self.currentLocation)
        self.doFillInformationLabels(parkingManager)

        
        var smsDetails: SmsFormat = parkingManager.fillOutMessageDetails()
        
        if (smsSender.canSendText()) {
            let messageComposeVC = smsSender.configuredMessageComposeViewController(smsDetails)
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages. Manually send an SMS to " + smsDetails.smsNumber + " the following message: " + smsDetails.toString(), delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    @IBAction func findCurrentLocation(sender: AnyObject) {
        let myAlert = UIAlertView(title: "Current Location",
            message: "You are in " + currentLocation.getCurrentCity().name,
            delegate: nil, cancelButtonTitle: "Ok")
        myAlert.show()
    
    }
    
    
    ///////////// picker view ////////////////
    
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
    
    //////////// sms sender ////////////
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        switch (result.value) {
        case MessageComposeResultCancelled.value:
            println("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.value:
            println("Message failed")
            successLabel.hidden = true
            errorLabel.hidden = false
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.value:
            println("Message was sent")
            successLabel.hidden = false
            errorLabel.hidden = true
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }

}

