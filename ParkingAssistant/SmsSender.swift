//
//  SmsSender.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 20/11/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation
class SmsSender {
    
    let smsNumber:String
    let body: String
    
    init(smsNumber: String, body:String) {
        self.smsNumber = smsNumber
        self.body = body
    }
    
    init(smsInfo: SmsDetails) {
        self.smsNumber = smsInfo.smsNumber
        self.body = smsInfo.smsBody
    }
    
    func sendMessage() -> Bool {
        return 1 == Int(arc4random_uniform(2))
    }
}