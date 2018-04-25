//
//  ViewController.swift
//  Hawaiian Weather
//
//  Created by Iain Moncrief on 3/23/18.
//  Copyright © 2018 Iain Moncrief. All rights reserved.
//

import UIKit
import CoreLocation
import OpenWeatherKit



class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        //self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        //weather grab test
        
        let weatherApi = WeatherApi(key: "9336dd32923469d935a7cc74234c1f5a")
        weatherApi.getWeatherFor(lat: "21.3582959405412", lon: "-157.93125104948") { result in
            switch result {
            case .success(let weather):
                //self.cityLabel.text = weather.name //UI builder connections
                //self.tempLabel.text = "\(weather.main.temp)" //UI builder connections
                print(weather.main.temp)
                print(weather)
            case .error(_):
                //Do something
                print("failed")
                break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //progress
        startLoadingScreen("")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        global.userLocation.latitude = locValue.latitude
        global.userLocation.longitude = locValue.longitude
        
        //Location uptdated call
        locationHasBeenUpdated()
        
        print("\(global.userLocation.longitude), \(global.userLocation.latitude)")
        
        if global.userLocation.latitude != 0.0 && global.userLocation.longitude != 0.0 {
            
            global.locationAvalible = true
            
            //print("locations = \(locValue.latitude) \(locValue.longitude)")
        } else {
            global.locationAvalible = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.denied {
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Location Required",
                                                message: "We need your location to deliver the weather to you.",
                                                preferredStyle: .alert)
        
        //let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) {(action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
