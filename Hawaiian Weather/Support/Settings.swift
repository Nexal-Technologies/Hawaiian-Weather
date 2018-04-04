//
//  Settings.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 4/3/18.
//  Copyright © 2018 Iain Moncrief. All rights reserved.
//

import Foundation

struct Settings {
    
    var speakPigeon : Bool = false
    
    var giveNotifications : Bool = true
    
    init() {
        if firstOpen() {
            
            self = defaults.object(forKey: "Settings") as! Settings
            
        }
        
        //self.isFirstOpen = firstOpen()
    }
    
    func save() {
        
        defaults.set(self, forKey: "Settings")
        
        //defaults.set(speakPigeon, forKey: "speakPigeon")
        //defaults.set(giveNotifications, forKey: "giveNotifications")
    }
    
}

//initialize with functions or class
var settings = Settings()