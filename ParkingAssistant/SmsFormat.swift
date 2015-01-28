//
//  SmsDetails.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 9/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

class SmsFormat {

    
    let SPACE: String = " "
    
    let smsNumber: String
    
    var smsBody: [String] = [String]()

    var actualBlock: String
    var actualStreet: String
    var actualLicensePlate: String
    var actualHours: String
    var actualKeyword: String
    var cardNumber: String
    
    init(smsNumber: String) {
        self.smsNumber = smsNumber
        self.actualBlock = ""
        self.actualStreet = ""
        self.actualLicensePlate = ""
        self.actualHours = ""
        self.actualKeyword = ""
        self.cardNumber = ""
    }

    func add(option: SmsBodyOption) {
        self.smsBody.append(option.rawValue)
    }
    
    func add(keyword: String) {
        self.smsBody.append(keyword)
    }
    
    
    func toString() -> String {
        var str = ""
        for eachOption in self.smsBody {
            var currentOptionStr = self.eval(eachOption)
            str += currentOptionStr + SPACE
        }
        return str
    }
    
    private func eval(option: String) -> String {
        switch option {
        case SmsBodyOption.Block.rawValue:
            return self.actualBlock
        case SmsBodyOption.LicensePlate.rawValue:
            return self.actualLicensePlate
        case SmsBodyOption.Street.rawValue:
            return self.actualStreet
        case SmsBodyOption.Hours.rawValue:
            return self.actualHours
        case SmsBodyOption.CardNumber.rawValue:
            return self.cardNumber
        default:
            return option
        }
        
    }
    
    func fillOutVariables(actualLicensePlate: String, actualBlock: String, actualStreet: String, actualHours: String, cardNumber: String?) {
        self.actualLicensePlate = actualLicensePlate
        self.actualBlock = actualBlock
        self.actualStreet = actualStreet
        self.actualHours = actualHours
        if (cardNumber != nil) {
            self.cardNumber = cardNumber!
        }
    }
    
}