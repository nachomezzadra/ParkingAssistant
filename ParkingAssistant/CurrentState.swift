//
//  CurrentState.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 28/1/15.
//  Copyright (c) 2015 Nacho Mezzadra. All rights reserved.
//

import Foundation

class CurrentState: Printable {

    private var lastUpdateTimeStamp = NSDate()
    private var currentState: ParkingState = ParkingState.Idle

    func startParking() {
        if (self.currentState == ParkingState.Parked) {
            println("Inconsistent state!")
        }
        self.currentState = ParkingState.Parked
        self.lastUpdateTimeStamp = NSDate()
        println("Started parking at \(self.lastUpdateTimeStamp)")

    }

    func stopParking() {
        if (self.currentState == ParkingState.Idle) {
            println("Inconsistent state!")
        }
        self.currentState = ParkingState.Idle
        self.lastUpdateTimeStamp = NSDate()
        println("Stopped parking at \(self.lastUpdateTimeStamp)")
    }
    
    func getLastUpdateTimeStamp() -> NSDate {
        return self.lastUpdateTimeStamp
    }
    
    func isParked() -> Bool {
        return self.currentState == ParkingState.Parked
    }
    
    var description: String {
        return "Current State:: \(currentState.rawValue)"
    }
}