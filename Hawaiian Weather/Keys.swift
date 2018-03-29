//
//  Keys.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 3/25/18.
//  Copyright © 2018 Iain Moncrief. All rights reserved.
//

import Foundation

struct keyBlock: Decodable {
    var key1: String?
    var key2: String?
    var key3: String?
}



class infoKey {
    
    var block = keyBlock()
    

    
    public func getKeys() {
        
        //fist time open*? UserDefaults BOOL
        
        if isFirstOpen {
            
            workingKey = "b6907d289e10d714a6e88b30761fae22"
            
        } else {
            
            workingKey = defaults.string(forKey: "workingKey")
            
            if validateKey(workingKey) {
                
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
                
                self.block = try JSONDecoder().decode(keyBlock.self, from: data!)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
        }.resume()
        
    }
    
    func validateKey(_ key: String?) -> Bool {
        
        
    }
}
