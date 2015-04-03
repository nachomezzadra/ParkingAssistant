//
//  CardRegistrationController.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 25/3/15.
//  Copyright (c) 2015 Nacho Mezzadra. All rights reserved.
//

import Foundation
import UIKit

class CardRegistrationController: UITableViewController, UITextFieldDelegate  {
    
    let smsSender = SmsSender()
    var parkingManager = ParkingManager()
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    override func viewDidAppear(animated: Bool) {
        self.cardNumberTextField.text = parkingManager.getCardNumber()
    }
    
    @IBAction func sendCardRegistrationSms(sender: UIButton) {
        if let cardNumber = self.cardNumberTextField?.text {
            var smsFormat: SmsFormat? = parkingManager.getCardSmsFormat(cardNumber)
            doSendSms(smsFormat!)
            parkingManager.setCardNumber(cardNumber)            
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
            errorAlert.show()
        }
    }
    
}