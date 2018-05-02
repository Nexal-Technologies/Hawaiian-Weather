//
//  WeatherManager.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 4/18/18.
//  Copyright © 2018 Nexal Technologies. All rights reserved.
//

import Foundation

struct StationID {
    
    let location: Location
    
    let name: String
    
}

class WeatherManager {
    
    var stations: [Station]
    
    init() {
        stations = defaults.array(forKey: "stations") as! [Station] //pull saved data from defaults
        stations[0] = Station(location: global.userLocation, true)
        for i in 0...stations.count {
            stations[i].updateCurrent()
            stations[i].updateForecast()
        } //update all stations
    }
    
    func addStation(location: Location) {
        if !(stations.count >= 6) {
            stations.append(Station(location: location, false))
        } else {
            //throuw user notification cannot have more than 6 stations
        }
    }
    
}
