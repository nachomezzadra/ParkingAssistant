//
//  ParkingInfo.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 20/11/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

class ParkingInfo {
    
    let licensePlate: String
    let currentLocation: CurrentLocation
    
    
    init(licensePlate:String, currentLocation:CurrentLocation) {
        self.licensePlate = licensePlate
        self.currentLocation = currentLocation
    }
    
    func getCity() -> String {
        return "Tandil"
    }
    
    
}