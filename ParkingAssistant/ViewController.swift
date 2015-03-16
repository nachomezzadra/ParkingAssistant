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

class ViewController: UITableViewController, UIPickerViewDelegate, MFMessageComposeViewControllerDelegate {


    @IBOutlet weak var locationTargetLabel: UILabel!
    @IBOutlet weak var smsDetails: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var smsNumber: UILabel!

    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var cardRegistrationButton: UIButton!
    @IBOutlet weak var timeCounterLabel: UILabel!
    @IBOutlet weak var stopParkingButton: UIButton!
    @IBOutlet weak var startParkingButton: UIButton!
    
    @IBOutlet weak var locationSegmentedControl: UISegmentedControl!
    
    let places: Places = Places()
    let smsSender = SmsSender()
    var parkingManager: ParkingManager!
    var timer: NSTimer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
//        updateUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        updateWithCurrentCity()
        doFillInformationLabels(self.parkingManager)
    }


    func doFillInformationLabels(parkingManager: ParkingManager) {
        locationTargetLabel.text = parkingManager.getCityName()
        smsDetails.text = parkingManager.getStartParkingSmsFormat().toString()
        licensePlateLabel.text = parkingManager.getLicensePlate()
        smsNumber.text = parkingManager.getStartParkingSmsFormat().smsNumber
    }


    @IBAction func sendRegistrationSms(sender: AnyObject) {
        let text: String = self.cardTextField!.text
        var smsFormat: SmsFormat? = parkingManager.getCardSmsFormat(text)
        doSendSms(smsFormat!)
    }

    @IBAction func stopParking(sender: AnyObject) {
        self.parkingManager.stopParking()
        println(self.parkingManager.getCurrentState())
        doStopTimer()
        displayParkingAbility()
        if (self.parkingManager.hasStopCapability()) {
            var smsFormat: SmsFormat = parkingManager.getStopSmsFormat()
            doSendSms(smsFormat)
        }
    }

    @IBAction func doPark(sender: AnyObject) {
        parkingManager.doPark()
        println(self.parkingManager.getCurrentState())
        var smsFormat: SmsFormat = parkingManager.getStartParkingSmsFormat()
        doSendSms(smsFormat)
        doStartTimer()
    }


    ///////////// timer //////////////////
    func doStopTimer() {
        self.timer.invalidate()
    }

    func doStartTimer() {
        timeCounterLabel.text = "00:00:00"
        // every second will call to updateCounter function
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }

    func updateCounter() {
        timeCounterLabel.text = calculateElapsedTimeFrom(parkingManager.getLastUpdateTimeStamp())
    }

    func calculateElapsedTimeFrom(aGivenTimeStamp: NSDate) -> String {
        var elapsedTime = abs(aGivenTimeStamp.timeIntervalSinceNow)

        //calculate the hours in elapsed time
        let hours = UInt8(elapsedTime / 60.0 / 60.0)
        elapsedTime -= (NSTimeInterval(hours) * 60 * 60)

        //calculate the minutes in elapsed time
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)

        //calculate the seconds in elapsed time
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)

        //fraction of milliseconds
        let fraction = UInt8(elapsedTime * 100)

        //add the leading zero for minutues, seconds and milliseconds, store
        // as string constants
        let strHours = hours > 9 ? String(hours) : "0" + String(hours)
        let strMinutes = minutes > 9 ? String(minutes) : "0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds) : "0" + String(seconds)


        //concatonate hours, mins, and seconds, assign to UILable timeCounter
        return "\(strHours):\(strMinutes):\(strSeconds)"
    }

    /////////////////////////////

    func updateWithCurrentCity() {
        self.parkingManager = ParkingManager()

        cardNumberLabel.hidden = !parkingManager.requiresParkingCard()
        cardTextField.hidden = !parkingManager.requiresParkingCard()
        cardRegistrationButton.hidden = !parkingManager.requiresParkingCard()
    }

    func displaySuccess() {
        println("Message was sent")
        successLabel.hidden = false
        errorLabel.hidden = true
    }

    func displayError() {
        println("Message failed")
        successLabel.hidden = true
        errorLabel.hidden = false
    }


    func displayParkingAbility() {
        println("Displaying Parking Ability. \(self.parkingManager.getCurrentState())")
        if self.parkingManager.isParked() {
            startParkingButton.hidden = true
            stopParkingButton.hidden = false
            timeCounterLabel.hidden = false
        } else {
            startParkingButton.hidden = false
            stopParkingButton.hidden = true
            timeCounterLabel.hidden = true
        }
    }

    //////////// sms sender ////////////

    func doSendSms(smsFormat: SmsFormat) {
        if (smsSender.canSendText()) {
            let messageComposeVC = smsSender.configuredMessageComposeViewController(smsFormat)
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages. Manually send an SMS to " + smsFormat.smsNumber + " the following message: " + smsFormat.toString(), delegate: self, cancelButtonTitle: "OK")
            displayParkingAbility()
            errorAlert.show()
        }
    }

    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        switch (result.value) {
        case MessageComposeResultCancelled.value:
            println("Message was cancelled")
            self.parkingManager.stopParking()
            displayError()
            displayParkingAbility()
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.value:
            displayError()
            self.parkingManager.stopParking()
            displayParkingAbility()
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.value:
            displaySuccess()
            doStartTimer()
            displayParkingAbility()
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }

}

