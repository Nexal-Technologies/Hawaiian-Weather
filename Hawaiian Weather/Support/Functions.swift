//
//  Functions.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 3/23/18.
//  Copyright © 2018 Iain Moncrief. All rights reserved.
//

import Foundation
import SVProgressHUD
import OpenWeatherKit


let defaults = UserDefaults.standard

func firstOpen() -> Bool {
    
    let theCode = defaults.integer(forKey: "firstTime")
    
    if theCode == 1 {
        return false
    } else {
        defaults.set(1, forKey: "firstTime")
        return true
    }
}

func startLoadingScreen(_ message: String?) {
    
    SVProgressHUD.setDefaultMaskType(.black)
    
    let Message = message ?? ""
    
    if Message == "" {
        SVProgressHUD.show()
    } else {
        SVProgressHUD.show(withStatus: Message)
    }
}

func stopLoadingScreen() {
    SVProgressHUD.dismiss()
}

func doubleToString(_ input: Double) -> String {
    return String(format:"%f", input)
}

func locationHasBeenUpdated() {
    let weatherApi = WeatherApi(key: "9336dd32923469d935a7cc74234c1f5a")
    weatherApi.getWeatherFor(lat: "\(doubleToString(global.userLocation.latitude))", lon: "\(doubleToString(global.userLocation.longitude))") { result in
        switch result {
        case .success(let weather):
            //self.cityLabel.text = weather.name //UI builder connections
            //self.tempLabel.text = "\(weather.main.)" //UI builder connections
            print(weather.weather[0].main)
        //print(weather)
        case .error(_):
            //Do something
            print("failed")
            break
        }
    }
}

