//
//  GetWeather.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 4/12/18.
//  Copyright © 2018 Nexal Technologies. All rights reserved.
//

import Foundation

class weather {
    
    var success: Bool = false
    
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        
        self.latitude = latitude
        self.longitude = longitude
        
        if !Network().checkConnection() {
            //no connection :(
            Network().noWifi()
            return
        }
        
        OpenWeatherMapKit.instance.currentWeather(forCoordiante: (latitude: 53.2610313, longitude: 50.0579958)) { (forecast, error) in
            
        }
    }
    
    func getForcast() {
        
    }
    
}

