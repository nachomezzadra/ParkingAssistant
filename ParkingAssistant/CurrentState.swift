//
//  CurrentState.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 28/1/15.
//  Copyright (c) 2015 Nacho Mezzadra. All rights reserved.
//

import Foundation

class CurrentState {

    var lastUpdateTimeStamp: NSDate = NSDate()
    var currentState: ParkingState = ParkingState.Idle

    func startParking() {
        if (self.currentState == ParkingState.Parked) {
            println("Inconsistent state!")
        }
        self.currentState = ParkingState.Parked
        self.lastUpdateTimeStamp = NSDate()

    }

    func stopParking() {
        if (self.currentState == ParkingState.Idle) {
            println("Inconsistent state!")
        }
        self.currentState = ParkingState.Idle
        self.lastUpdateTimeStamp = NSDate()
    }
}