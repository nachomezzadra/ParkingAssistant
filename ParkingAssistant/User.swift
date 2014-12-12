//
//  User.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 7/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation


class User{
    
    let licensePlates: [String]
    let licensePlate: String
    var currentLocation: CurrentLocation
    
    init(licensePlate:String) {
        self.licensePlate = licensePlate
        licensePlates = [licensePlate]
        self.currentLocation = CurrentLocation()
    }
    
    func getParkingInfo() -> ParkingInfo {
        return ParkingInfo(licensePlate: self.licensePlate, currentLocation: currentLocation)
    }
}