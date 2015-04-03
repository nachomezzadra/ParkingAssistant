
//
//  ParkingManager.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 20/11/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

public class ParkingManager {
    
    private let userSettings = UserSettings()
    private var currentLocation: CurrentLocation
    private var currentState = CurrentState()
    
    
    init() {
        if userSettings.automaticallyDetermineLocation {
            self.currentLocation = CurrentLocationAuto()
        } else {
            self.currentLocation = CurrentLocationManual(currentCity: userSettings.lastKnownLocation)
        }
    }
    
    
    func getCityName() -> String {
        return self.currentLocation.getCurrentCity().name
    }
    
    func getStartParkingSmsFormat() -> SmsFormat {
        fillOutMessageDetails(nil)
        return currentLocation.getCurrentCity().smsParkingSet.smsStart
    }

    func getStopSmsFormat() -> SmsFormat {
        fillOutMessageDetails(nil)
        return currentLocation.getCurrentCity().smsParkingSet.smsStop!
    }

    func getCardSmsFormat(cardNumber: String) -> SmsFormat {
        fillOutMessageDetails(cardNumber)
        return currentLocation.getCurrentCity().smsParkingSet.smsCard!
    }

    private func fillOutMessageDetails(cardNumber: String?) {
        currentLocation.getCurrentCity().smsParkingSet.fillOutVariables(self.userSettings.licensePlate, actualBlock: self.currentLocation.getCurrentBlock(), actualStreet: self.currentLocation.getCurrentStreet(), actualHours: "1", cardNumber: cardNumber)
    }
    
    func getLicensePlate() -> String {
        return self.userSettings.licensePlate
    }
    
    func requiresParkingCard() -> Bool {
        return self.currentLocation.getCurrentCity().requiresParkingCard()
    }
    
    func hasStopCapability() -> Bool {
        return currentLocation.getCurrentCity().smsParkingSet.smsStop != nil
    }
    
    
    func doPark() {
        self.currentState.startParking()
    }
    
    func stopParking() {
        self.currentState.stopParking()
    }
    
    func isParked() -> Bool {
        return self.currentState.isParked()
    }
    
    func getCurrentState() -> CurrentState {
        return self.currentState
    }
    
    func getLastUpdateTimeStamp() -> NSDate {
        var startedParking = self.currentState.getLastUpdateTimeStamp()
        /*let newDate = NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitHour,
            value: 2,
            toDate: startedParking,
            options: NSCalendarOptions(0))*/
        return startedParking
    }
    
    func setCardNumber(cardNumber: String) {
        self.userSettings.cardNumber = cardNumber
        self.userSettings.save()
    }
    
    func getCardNumber() -> String {
        return self.userSettings.cardNumber
    }
    
}