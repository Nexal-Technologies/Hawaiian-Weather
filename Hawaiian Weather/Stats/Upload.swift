//
//  Upload.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 5/2/18.
//  Copyright © 2018 Nexal Technologies. All rights reserved.
//

import Foundation

func sendUserData() {
    var components = URLComponents(string: "https://api.nexal.net/deposituserstats.php")
    components?.queryItems = [
        URLQueryItem(name: "fname", value: (settings.userSettings.firstname as! String)),
        URLQueryItem(name: "lname", value: (settings.userSettings.lastName as! String)),
        URLQueryItem(name: "email", value: (settings.userSettings.email as! String)),
        URLQueryItem(name: "phone", value: (settings.userSettings.phone as! String)),
        URLQueryItem(name: "userCurrentLocationLat", value: ("\(doubleToString(global.userLocation.latitude))")),
        URLQueryItem(name: "userCurrentLocationLong", value: ("\(doubleToString(global.userLocation.longitude))")),
        //yo howzit?!?

    ]
    
    guard let url = components?.url else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    print("upload sucsessful!")
}
