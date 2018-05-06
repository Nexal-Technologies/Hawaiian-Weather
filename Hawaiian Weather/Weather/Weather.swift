//
//  Weather.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 4/26/18.
//  Copyright © 2018 Nexal Technologies. All rights reserved.
//

import Foundation
import OpenWeatherKit


class Station {
    
    var isCurrentStation: Bool //is wthe station determined by the users location
    
    let key: String
    
    var location: Location
    
    var weatherAvalible: Bool = false
    
    var success: Bool = false
    
    var currentWeather: Weather?
    var forecastWeather: Forecast?
    
    let weatherApi: WeatherApi
    
    init(location: Location, _ isCurrentStation: Bool) {
        self.location = location
        self.isCurrentStation = isCurrentStation
        
        self.key = global.workingKey
        
        self.weatherApi = WeatherApi(key: self.key)
        

        
    }
    
    func updateCurrent() {
        
        //network check
        if !Network().checkConnection() {
            //no connection :(
            Network().noWifi()
            print("unable to grab data because no wifi.")
            return
        }
        
        self.weatherApi.getWeatherFor(lat: "\(doubleToString(self.location.latitude))", lon: "\(doubleToString(self.location.longitude))") { result in
            switch result {
            case .success(let weather):
                
                self.currentWeather = weather
                
                print(weather)
                
                
            case .error(_):
                
                debug("Failed to grab weather data!")
                self.failedToGrabData()
                break
            }
        }
    }
    

    
    func updateForecast() {
        
        //network check
        if !Network().checkConnection() {
            //no connection :(
            Network().noWifi()
            return
        }
        
        weatherApi.getForecastFor(lat: "\(doubleToString(self.location.latitude))", lon: "\(doubleToString(self.location.longitude))") { result in
            switch result {
            case .success(let weather):
                
                self.forecastWeather = weather
                print(weather)
                
            case .error(_):
                
                debug("Failed to grab weather data!")
                self.failedToGrabData()
                break
            }
        }
        
    }
    
    func failedToGrabData() {
        
    }
}
