
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
    let smsSender: SmsSender = SmsSender()
    var currentLocation: CurrentLocation
    
    
    
    init(currentLocation: CurrentLocation) {
        self.currentLocation = currentLocation
    }
    
    
    public func doBuyParkingPermit() -> Bool {
        return self.smsSender.sendMessage(fillOutMessageDetails())
    }
    
    func getCityName() -> String {
        return self.currentLocation.getCurrentCity().name
    }
    
    func getSmsDetails() -> SmsDetails {
        return fillOutMessageDetails()
    }
    
    func fillOutMessageDetails() -> SmsDetails {
        var smsDetails: SmsDetails = currentLocation.getCurrentCity().smsInfo
        smsDetails.actualLicensePlate = self.user1.licensePlate
        smsDetails.actualBlock = self.currentLocation.getCurrentBlock()
        smsDetails.actualStreet = self.currentLocation.getCurrentStreet()
        return smsDetails
    }
    
    func getLicensePlate() -> String {
        return self.user1.licensePlate
    }
    
}