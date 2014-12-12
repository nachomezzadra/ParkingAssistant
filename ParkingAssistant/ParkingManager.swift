
//
//  ParkingManager.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 20/11/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

public class ParkingManager {
    
    let user1 = User(licensePlate: "NFV743")
    let smsSender: SmsSender
    
    
    public init() {
        self.smsSender = SmsSender(smsInfo: user1.currentLocation.getCity().smsInfo)
    }
    
    public func doBuyParkingPermit() -> Bool {
        return smsSender.sendMessage()
    }
    
    func getCityName() -> String {
        return self.user1.currentLocation.getCity().name
    }
    
    func getSmsDetails() -> String {
        return "Sms body: " + self.user1.getParkingInfo().currentLocation.smsDetails.smsBody + ", sms number" + self.user1.getParkingInfo().currentLocation.smsDetails.smsNumber
    }
    
    func getLicensePlate() -> String {
        return self.user1.getParkingInfo().licensePlate
    }
    
}