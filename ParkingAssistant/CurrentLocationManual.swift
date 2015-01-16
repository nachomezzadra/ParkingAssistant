//
//  CurrentLocation.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 7/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocationManual: CurrentLocation {

    let places: Places
    var currentCityStr: String


    init(currentCity: String) {
        self.places = Places()
        self.currentCityStr = currentCity
    }
    
    func getCurrentCity() -> City {
        return places.getCityFrom(self.currentCityStr)!
    }
    
    
    func getCurrentStreet() -> String {
        return "Unknown street"
    }
    
    
    func getCurrentBlock() -> String {
        return "Unknown block"
    }
    
    
}