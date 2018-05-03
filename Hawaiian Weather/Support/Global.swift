//
//  Global.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 3/27/18.
//  Copyright © 2018 Iain Moncrief. All rights reserved.
//

import Foundation

struct Global {
    
    var isConnectedToInternet : Bool = false
    
    var workingKey : String = "9336dd32923469d935a7cc74234c1f5a"
    
    var isFirstOpen : Bool = true
    
    var locationAvalible : Bool = false
    var locationAllowed : Bool = false
    
    //var network = Network()
    
    var userLocation : Location
    
    var inHawaii : Bool = false
    
    //var keyBlock = KeyBlock()
    
    var debug = true
    
    init() {
        
        self.isFirstOpen = firstOpen()
        self.userLocation = Location()
        
    }
}

struct Location {
    var longitude : Double = 0.0
    var latitude : Double = 0.0
}

//initialize with functions or class
var global = Global()
var weatherManager = WeatherManager()
