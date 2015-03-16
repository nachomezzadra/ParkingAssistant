//
//  User.swift
//  auto-park
//
//  Created by Nacho Mezzadra on 7/12/14.
//  Copyright (c) 2014 Nacho Mezzadra. All rights reserved.
//


// take a look http://www.codingexplorer.com/nsuserdefaults-a-swift-introduction/
import Foundation

class UserSettings {
    
    private let licensePlateKey = "licensePlateKey"
    private let automaticallyDetermineLocationKey = "automaticallyDetermineLocationKey"
    private let lastKnownLocationKey = "lastKnownLocationKey"

    private let defaults = NSUserDefaults.standardUserDefaults()

    private let unknownLocation = "Unknown Location"

    var licensePlate = ""
    var automaticallyDetermineLocation = false
    var lastKnownLocation: String = ""
    
    init() {
        self.load()
    }
    
    func save() {
        defaults.setObject(licensePlate, forKey: licensePlateKey)
        defaults.setObject(automaticallyDetermineLocation, forKey: automaticallyDetermineLocationKey)
        defaults.setObject(lastKnownLocation, forKey: lastKnownLocationKey)
    }
    
    func load() {
        if let licPlate = defaults.stringForKey(licensePlateKey) {
            self.licensePlate = licPlate
        }
        self.automaticallyDetermineLocation = defaults.boolForKey(automaticallyDetermineLocationKey)
        
        self.lastKnownLocation = defaults.stringForKey(lastKnownLocationKey) ?? unknownLocation

    }

    func lastLocationIsUnknown() -> Bool {
        return (self.lastKnownLocation.isEmpty)
    }
}