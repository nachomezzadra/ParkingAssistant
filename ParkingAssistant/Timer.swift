//
//  Timer.swift
//  ParkingAssistant
//
//  Created by Nacho Mezzadra on 5/2/15.
//  Copyright (c) 2015 Nacho Mezzadra. All rights reserved.
//
// http://www.samuelmullen.com/2014/07/using-swifts-closures-with-nstimer
//
// Usage:
//
//  @IBOutlet func displayTimeRemaining(elapsedTime) {
//    var timeRemaining = self.duration - elapsedTime
//    timerView.value = timeRemaining
//   }
//

import Foundation

class Timer {
    var timer = NSTimer()
    var handler: (Int) -> ()
    
    let duration: Int
    var elapsedTime: Int = 0
    
    init(duration: Int, handler: (Int) -> ()) {
        self.duration = duration
        self.handler = handler
    }
    
    func start() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            target: self,
            selector: Selector("tick"),
            userInfo: nil,
            repeats: true)
    }
    
    func stop() {
        timer.invalidate()
    }
    
    @objc func tick() {
        self.elapsedTime++
        
        self.handler(elapsedTime)
        
        if self.elapsedTime == self.duration {
            self.stop()
        }
    }
    
    deinit {
        self.timer.invalidate()
    }
}