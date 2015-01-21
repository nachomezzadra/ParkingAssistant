//
//  SmsSender.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 20/11/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation
import MessageUI

class SmsSender: NSObject, MFMessageComposeViewControllerDelegate {
    
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController(smsDetails: SmsFormat) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.messageComposeDelegate = self
        messageComposeVC.recipients = [smsDetails.smsNumber]
        messageComposeVC.body = smsDetails.toString()
        return messageComposeVC
    }
    
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}