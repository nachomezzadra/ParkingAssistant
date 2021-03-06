//
//  City.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 7/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation


class City {
    
    let name: String
    let latitude: Double
    let longitude: Double
    let smsParkingSet: SmsParkingSet
    
    
    init(name:String, latitude:Double, longitude:Double, smsParkingSet: SmsParkingSet) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.smsParkingSet = smsParkingSet
    }
    
    func requiresParkingCard() -> Bool {
        return self.smsParkingSet.hasCardSms()
    }
    
    func hasStopCapability() -> Bool {
        return self.smsParkingSet.hasStopSms()
    }

}