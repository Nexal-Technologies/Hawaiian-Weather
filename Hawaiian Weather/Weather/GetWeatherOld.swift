//
//  GetWeather.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 3/23/18.
//  Copyright © 2018 Iain Moncrief. All rights reserved.
//

import Foundation

struct WeatherBlock : Decodable {
    let temp_min: Float?
    let temp_max: Float?
    let wind_speed: Float?
    let humidity: Int?
    let name: String?
    let main: String?
    var description: String?
    
    let cod: Int? // error code... 200 = working :)
}

class weatherOld {
    
    var success: Bool = false
    
    let apiURL : URL?
    
    var block: WeatherBlock?
    
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        
        self.latitude = latitude
        self.longitude = longitude
        
        if !Network().checkConnection() {
            //no connection :(
            Network().noWifi()
            
            self.apiURL = nil
            return
        }
        
        let keyGet = infoKey()
        keyGet.getKeys()
        
        let apiURLstring = "http://api.openweathermap.org/data/2.5/weather?lat=\(global.userLocation.latitude)&lon=\(global.userLocation.longitude)&appid=9336dd32923469d935a7cc74234c1f5a"
        self.apiURL = URL(string: apiURLstring)
        
        URLSession.shared.dataTask(with: self.apiURL!) {(data, response, err) in
            //perhaps check err
            //perhaps check response 200 OK
            
            let data = data
            
            do {
                
                self.block = try JSONDecoder().decode(WeatherBlock.self, from: data!)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                //self.block = try JSONDecoder().decode(WeatherBlock.self, from: data!)
            }
            
        }.resume()
        
    }
    
    func analyze() {
        if self.block?.cod != 200 {
            return
        } else if self.block?.cod == 401 {
            self.success = true
        }
        
        let dat = self.block
        let weatherString = dat?.main
        
    }
    
    func retry() {
        
    }
    
}
