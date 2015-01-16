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
    let smsInfo: SmsDetails
    
    init(name:String, latitude:Double, longitude:Double, smsInfo: SmsDetails) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.smsInfo = smsInfo
    }

}