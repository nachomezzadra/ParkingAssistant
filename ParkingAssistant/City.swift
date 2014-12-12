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
    let location: String
    let smsInfo: SmsDetails
    
    init(name:String, location:String, smsInfo: SmsDetails) {
        self.location = location
        self.name = name
        self.smsInfo = smsInfo
    }

}