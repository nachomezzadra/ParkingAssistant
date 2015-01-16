//
//  CurrentLocation.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 7/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocationAuto: CurrentLocation {

    let places: Places
    var manager: OneShotLocationManager?


    init() {
        self.places = Places()
    }
    
    func getCurrentCity() -> City {
        var currentCityAsStr = self.doGetCurrentCity()
        return places.getCityFrom(currentCityAsStr)!
    }
    
    private func doGetCurrentCity() -> String {
        manager = OneShotLocationManager()
        var cityAsStr: String = "";
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc = location {
                //self.label.text = loc.description
                cityAsStr = loc.locality
            } else if let err = error {
                //self.label.text = err.localizedDescription
                //self.locationTargetLabel.text = err.localizedDescription
                cityAsStr = ""
            }
            
            // destroy the object immediately to save memory
            self.manager = nil
        }
        return cityAsStr
    }
    
    func getCurrentStreet() -> String {
        manager = OneShotLocationManager()
        var streetAsStr: String = "";
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc = location {
                streetAsStr = loc.thoroughfare
            } else if let err = error {
                streetAsStr = ""
            }
            
            // destroy the object immediately to save memory
            self.manager = nil
        }
        return streetAsStr
    }
    
    
    func getCurrentBlock() -> String {
        manager = OneShotLocationManager()
        var blockAsStr: String = "";
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc = location {
                blockAsStr = loc.subThoroughfare
            } else if let err = error {
                blockAsStr = ""
            }
            
            // destroy the object immediately to save memory
            self.manager = nil
        }
        return blockAsStr
    }
    
    func getCLPlacemark() -> CLPlacemark {
        manager = OneShotLocationManager()
        var clPlaceMark: CLPlacemark = CLPlacemark()
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc = location {
                clPlaceMark = loc
            } else if let err = error {
//                clPlaceMark = nil
                println("error")
            } 
            
            // destroy the object immediately to save memory
            self.manager = nil
        }
        return clPlaceMark
    }
    
}