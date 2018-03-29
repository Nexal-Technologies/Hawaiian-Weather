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

class weather {
    
    let latitude : Float?
    let longitude : Float?
    
    
    let key: String?
    
    let apiURL : URL?
    
    var block: WeatherBlock?
    
    init(latitude: Float, longitude: Float) {
        
        let keyGet = infoKey()
        keyGet.getKeys()
        self.key = workingKey
        
        self.latitude = latitude
        self.longitude = longitude
        
        let apiURLstring = "http://api.openweathermap.org/data/2.5/weather?lat=\(self.latitude)&lon=\(self.longitude)&appid=\(workingKey)"
        self.apiURL = URL(string: apiURLstring)
        
        URLSession.shared.dataTask(with: self.apiURL!) {(data, response, err) in
            //perhaps check err
            //perhaps check response 200 OK
            
            let data = data
            
            do {
                
                self.block = try JSONDecoder().decode(WeatherBlock.self, from: data!)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            }.resume()
        
    }
    
    func analyze() {
        if self.block?.cod! != 200 {
            return
        } else if self.block.cod == 401 {
            return
        }
        
        let dat = self.block
        
    }
    
}
