//
//  CurrentLocation.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 7/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//

import Foundation

protocol CurrentLocation {
    
    func getCurrentCity() -> City
    
    func getCurrentStreet() -> String
    
    func getCurrentBlock() -> String

}