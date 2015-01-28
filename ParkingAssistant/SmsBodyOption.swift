//
//  SmsBodyOptions.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 22/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

enum SmsBodyOption: String {
    case Block = "<BLOCK>"
    case Hours = "<HOURS>"
    case LicensePlate = "<LICENSE_PLATE>"
    case Street = "<STREET>"
    case CardNumber = "<CARD_NUMBER>"
}