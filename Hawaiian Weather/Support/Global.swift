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
    
    var workingKey : String = ""
    
    var isFirstOpen : Bool = true
    
    var locationAvalible : Bool = false
    var locationAllowed : Bool = false
    var latitude = 0.0
    var longitude = 0.0
    
    //var network = Network()
    
    var inHawaii : Bool = false
    
    var keyBlock = KeyBlock()
    
    init() {
        
        self.isFirstOpen = firstOpen()
        
    }
}

//initialize with functions or class
var global = Global()
