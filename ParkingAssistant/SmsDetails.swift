//
//  SmsDetails.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 9/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

class SmsDetails{

    let smsNumber: String
    let smsBody: String
    
    init(smsNumber: String, smsBody: String) {
        self.smsBody = smsBody
        self.smsNumber = smsNumber
    }
    
}