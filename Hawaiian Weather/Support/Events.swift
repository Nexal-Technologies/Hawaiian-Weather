//
//  Events.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 4/26/18.
//  Copyright © 2018 Nexal Technologies. All rights reserved.
//

import Foundation
class Events {
    
    var fiveMinute: Timer!
    var tenMinute: Timer!
    var fifteenMinute: Timer!
    
    func startSchedule() {
        fiveMinute = Timer.scheduledTimer(timeInterval: 300.0, target: self, selector: #selector(fiveMinuteCall), userInfo: nil, repeats: true) //every 5 mins
        tenMinute = Timer.scheduledTimer(timeInterval: 300.0, target: self, selector: #selector(tenMinuteCall), userInfo: nil, repeats: true) //every 10 mins
        fifteenMinute = Timer.scheduledTimer(timeInterval: 300.0, target: self, selector: #selector(fifteenMinuteCall), userInfo: nil, repeats: true) //every 15 mins
    }
    
    @objc func fiveMinuteCall() {
        
    }
    @objc func tenMinuteCall() {
        
    }
    @objc func fifteenMinuteCall() {
        sendUserData()
        
    }
}
