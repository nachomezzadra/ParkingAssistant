//
//  CurrentLocation.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 7/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation


class CurrentLocation {

    var smsDetails = SmsDetails(smsNumber: "*555", smsBody: "<LICENSE_PLATE> <LOCATION>")
    let city: City
    

    init() {
        self.city = City(name: "Tandil", location: "x:54322, y:99823", smsInfo: self.smsDetails)
    }
    
    func getCity() -> City {
        return self.city
    }
    
}