//
//  SmsSender.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 20/11/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation
class SmsSender {
    
    init() {
    }
    
    func sendMessage(smsDetails: SmsDetails) -> Bool {
        return 1 == Int(arc4random_uniform(2))
    }
}