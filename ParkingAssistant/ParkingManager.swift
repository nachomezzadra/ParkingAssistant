
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
    var currentLocation: CurrentLocation
    
    
    init(currentLocation: CurrentLocation) {
        self.currentLocation = currentLocation
    }
    
    
    func getCityName() -> String {
        return self.currentLocation.getCurrentCity().name
    }
    
    func getStartParkingSmsFormat() -> SmsFormat {
        fillOutMessageDetails(nil)
        return currentLocation.getCurrentCity().smsParkingSet.smsStart
    }
    
    func getCardSmsFormat(cardNumber: String) -> SmsFormat {
        fillOutMessageDetails(cardNumber)
        return currentLocation.getCurrentCity().smsParkingSet.smsCard!
    }
    
    private func fillOutMessageDetails(cardNumber: String?) {
        currentLocation.getCurrentCity().smsParkingSet.fillOutVariables(self.user1.licensePlate, actualBlock: self.currentLocation.getCurrentBlock(), actualStreet: self.currentLocation.getCurrentStreet(), actualHours: "1", cardNumber: cardNumber)
    }
    
    func getLicensePlate() -> String {
        return self.user1.licensePlate
    }
    
    func requiresParkingCard() -> Bool {
        return self.currentLocation.getCurrentCity().requiresParkingCard()
    }
    
    
}