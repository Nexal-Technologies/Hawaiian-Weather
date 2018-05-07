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
    
    var workingKey : String = "9336dd32923469d935a7cc74234c1f5a"
    
}

class WeatherManager {
    
    let currentStationCurrentWeatherUpdateInterval: Double = 300.0 // five minutes
    let currentStationForecastWeatherUpdateInterval: Double = 600.0 // ten minutes
    
    let externalStationCurrentWeatherUpdateInterval: Double = 1200.0 // twenty minutes
    let externalStationForecastWeatherUpdateInterval: Double = 1800.0 // thirty minutes
    
    var stations: [Station] = []
    
    //var currentStation: Station
    
    //for the station where the user is.
    var currentCurrentWeatherUpdateTimer: Timer!
    var currentForecastWeatherUpdateTimer: Timer!
    
    //all other stations besided the local station (where the user is)
    var stationsCurrentWeatherUpdateTimer: Timer!
    var stationsForecastWeatherUpdateTimer: Timer!
    
    init() {
        
        if defaults.array(forKey: "stations") != nil {
            stations = defaults.array(forKey: "stations") as! [Station] //pull saved data from defaults
        } else {
            stations.append(Station(location: global.userLocation, true))
        }
        
        stations[0] = Station(location: global.userLocation, true)
        
        //currentStation = stations[0]
        
        for i in 0...(stations.count - 1) { //minus one because count automaticaly returns the ammount, not ht eindex number...
            stations[i].updateCurrent()
            stations[i].updateForecast()
        } //update all stations
        
        //updating UI
        updateVC()
        
        //for the station where the user is.
        currentCurrentWeatherUpdateTimer = Timer.scheduledTimer(timeInterval: currentStationCurrentWeatherUpdateInterval, target: self, selector: #selector(updateCurrentStationCurrent), userInfo: nil, repeats: true) //every 5 mins
        currentForecastWeatherUpdateTimer = Timer.scheduledTimer(timeInterval: currentStationForecastWeatherUpdateInterval, target: self, selector: #selector(updateCurrentStationForecast), userInfo: nil, repeats: true) //every 10 mins
        
        //all other stations besided the local station (where the user is)
        stationsCurrentWeatherUpdateTimer = Timer.scheduledTimer(timeInterval: 900.0, target: self, selector: #selector(updateCurrentStationCurrent), userInfo: nil, repeats: true) // every 15 mins
        stationsForecastWeatherUpdateTimer = Timer.scheduledTimer(timeInterval: 1200.0, target: self, selector: #selector(updateCurrentStationCurrent), userInfo: nil, repeats: true) // every 20 mins
        
    }
    
    func updateStationCurrentWeather() {
        for i in 1...(stations.count - 1) { //minus one because count automaticaly returns the ammount, not ht eindex number...
            stations[i].updateCurrent()
        } //update all stations
    }
    
    func updateStationForecastWeather() {
        for i in 1...(stations.count - 1) { //minus one because count automaticaly returns the ammount, not ht eindex number...
            print("updateStationForecastWeather()")
            stations[i].updateForecast()
        } //update all stations
    }
    
    
    func addStation(location: Location) {
        if !(stations.count >= 6) {
            stations.append(Station(location: location, false))
            stations[stations.count - 1].updateCurrent()
            stations[stations.count - 1].updateForecast()
            updateVC()
        } else {
            //throw user notification cannot have more than 6 stations
            showWarning(title: "Station Limit!", subTitle: "You may not have more than 6 stations. Currently we cannot afford for each user to have 6 stations.😕 You can help us reach our goal of $2,500 by going to our site: nexal.net This will give us the funding we need to add features to the app and make users have more that 6 stations!")
        }
    }
    
    
    // Updates current and forecast data for current station.
    @objc func updateCurrentStationCurrent() {
            stations[0] = Station(location: global.userLocation, true) //gives new location
            stations[0].updateCurrent() //updates weather
            print("updateCurrentStationCurrent()")
            updateVC()
            //currentStation = stations[0]
        
    }
    
    @objc func updateCurrentStationForecast() {
            stations[0] = Station(location: global.userLocation, true)
            stations[0].updateCurrent()
            print("updateCurrentStationForecast()")
            updateVC()
            //currentStation = stations[0]
    }
    
    func updateVC() {
        startLoadingScreen("Updating Weather")
        print("4 sec start")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
//            ViewController().updateUI()
//        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { // change 2 to desired number of seconds
            print("4 sec end")
            ViewController().updateUI()
        }
    }
}
