//
//  Keys.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 3/25/18.
//  Copyright © 2018 Iain Moncrief. All rights reserved.
//

import Foundation

struct KeyBlock: Decodable {
    var key1: String?
    var key2: String?
    var key3: String?
}

class infoKey {
    
    public func getKeys() {
        
        //fist time open*? UserDefaults BOOL
        
        if global.isFirstOpen {
            
            global.workingKey = "b6907d289e10d714a6e88b30761fae22"
            
            if validateKey(global.workingKey) {
                //key works!
                
            } else {
                //key does not work...
                updateKeys()
                
            }
            
        } else {
            
            global.workingKey = defaults.string(forKey: "workingKey")!
            
            if validateKey(global.workingKey) {
                //key works!
                
            } else {
                
                updateKeys()
                
            }
        }
    }
    
    private func updateKeys() {
        
        let keyJSONAddr = "http://api.nexal.net/hawaiianweather/keys.json"
        
        let keyjsonURL = URL(string: keyJSONAddr)
        
        URLSession.shared.dataTask(with: keyjsonURL!) {(data, response, err) in
            //perhaps check err
            //perhaps check response 200 OK
            
            let data = data
            
            do {
                
                global.keyBlock = try JSONDecoder().decode(KeyBlock.self, from: data!)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
        }.resume()
        
    }
    
    func validateKey(_ key: String) -> Bool {
        
        return true
    }
}
