//
//  SmsParkingSet.swift
//  ParkingAssistant
//
//  This class represents a set of SMSs that will be used to register a phone, start parking, stop parking, and subscribe a parking Card if needed.  The only required SmsFormat is the one to start parking.
//
//  Created by Nacho Mezzadra on 20/1/15.
//  Copyright (c) 2015 Nacho Mezzadra. All rights reserved.
//

import Foundation

class SmsParkingSet {

    let smsStart: SmsFormat
    let smsStop: SmsFormat?
    let smsRegister: SmsFormat?
    let smsCard: SmsFormat?
    let smsBalance: SmsFormat?
    
    init(smsStart: SmsFormat, smsStop: SmsFormat?, smsRegister: SmsFormat?, smsCard: SmsFormat?, smsBalance: SmsFormat?) {
        self.smsStart = smsStart
        self.smsStop = smsStop
        self.smsRegister = smsRegister
        self.smsCard = smsCard
        self.smsBalance = smsBalance
    }
    
    func fillOutVariables(actualLicensePlate: String, actualBlock: String, actualStreet: String, actualHours: String, cardNumber: String?) {
        smsStart.fillOutVariables(actualLicensePlate, actualBlock: actualBlock, actualStreet: actualStreet, actualHours: actualHours, cardNumber: nil)

        if (self.hasStopSms()) {
            smsStop!.fillOutVariables(actualLicensePlate, actualBlock: actualBlock, actualStreet: actualStreet, actualHours: actualHours, cardNumber: nil)
        }
        

        if (self.hasRegisterSms()) {
            smsRegister!.fillOutVariables(actualLicensePlate, actualBlock: actualBlock, actualStreet: actualStreet, actualHours: actualHours, cardNumber: nil)
        }

        if (self.hasCardSms()) {
            smsCard!.fillOutVariables(actualLicensePlate, actualBlock: actualBlock, actualStreet: actualStreet, actualHours: actualHours, cardNumber: cardNumber)
        }

        if (self.hasBalanceSms()) {
            smsBalance!.fillOutVariables(actualLicensePlate, actualBlock: actualBlock, actualStreet: actualStreet, actualHours: actualHours, cardNumber: nil)
        }
    }
    
    
    
    func hasStopSms() -> Bool {
        return self.smsStop != nil
    }
    
    func hasRegisterSms() -> Bool {
        return self.smsRegister != nil
    }
    
    func hasCardSms() -> Bool {
        return self.smsCard != nil
    }
    
    func hasBalanceSms() -> Bool {
        return self.smsBalance != nil
    }
}