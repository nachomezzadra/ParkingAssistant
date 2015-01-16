//
//  SmsDetails.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 9/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

class SmsDetails {

    
    let SPACE: String = " "
    
    let smsNumber: String
    
    var smsBody: [SmsBodyOption] = [SmsBodyOption]()

    var actualBlock: String
    var actualStreet: String
    var actualLicensePlate: String
    var actualHours: String
    var actualKeyword: String
    
    init(smsNumber: String) {
        self.smsNumber = smsNumber
        self.actualBlock = ""
        self.actualStreet = ""
        self.actualLicensePlate = ""
        self.actualHours = ""
        self.actualKeyword = ""
    }

    func add(option: SmsBodyOption) {
        self.smsBody.append(option)
    }
    
    
    func toString() -> String {
        var str = ""
        for eachOption in self.smsBody {
            var currentOptionStr = self.eval(eachOption)
            str += currentOptionStr + SPACE
        }
        return str
    }
    
    private func eval(option: SmsBodyOption) -> String {
        switch option {
        case SmsBodyOption.Block:
            return self.actualBlock
        case SmsBodyOption.LicensePlate:
            return self.actualLicensePlate
        case SmsBodyOption.Street:
            return self.actualStreet
        case SmsBodyOption.Hours:
            return self.actualHours
        case SmsBodyOption.Keyword:
            return self.actualKeyword
        default:
            return ""
        }
        
    }
    
}