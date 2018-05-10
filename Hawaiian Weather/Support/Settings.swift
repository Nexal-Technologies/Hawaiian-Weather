//
//  Settings.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 4/3/18.
//  Copyright © 2018 Iain Moncrief. All rights reserved.
//

import Foundation

struct Settings {
    
    var userSettings: UserSettings = UserSettings()
    
    var speakPidgin : Bool = false
    
    var giveNotifications : Bool = true
    
    init() {
        if !firstOpen() && !(defaults.object(forKey: "Settings") == nil) {
            
            self = defaults.object(forKey: "Settings") as! Settings
            
        } else {
            self.save()
        }
        
        //self.isFirstOpen = firstOpen()
    }
    
    func save() {
        
        defaults.set(self, forKey: "Settings")
        
        //defaults.set(speakPigeon, forKey: "speakPigeon")
        //defaults.set(giveNotifications, forKey: "giveNotifications")
    }
}

struct UserSettings {
    var firstname: Any = "nil"
    var lastName: Any = "nil"
    var email: Any?
    var phone: Any?
}

//initialize with functions or class
var settings = Settings()
