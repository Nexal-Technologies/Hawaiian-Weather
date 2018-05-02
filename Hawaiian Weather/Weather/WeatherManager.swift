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
            showWarning(title: "Station Limit!", subTitle: "You may not have more than 6 stations. Currently we cannot afford for each user to have 6 stations.😕 You can help us reach our goal of $2,500 by going to our site: nexal.net This will give us the funding we need to add features to the app and make users have more that 6 stations!")
        }
    }
    
}
