//
//  GetLocation.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 3/25/18.
//  Copyright © 2018 Iain Moncrief. All rights reserved.
//

import Foundation

func isInHawaii() -> Bool {
    if ((global.latitude >= 18.0) && (global.latitude >= -160.0)) && ((global.latitude <= 23.0) && (global.latitude <= -153.0)) {
        global.inHawaii = true
        return true
    } else {
        global.inHawaii = false
        return false
    }
}
