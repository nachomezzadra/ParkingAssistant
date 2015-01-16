//
//  User.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 7/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation


class User {
    
    let licensePlates: [String]
    let licensePlate: String

    
    init(licensePlate:String) {
        self.licensePlate = licensePlate
        licensePlates = [licensePlate]
    }
    
}