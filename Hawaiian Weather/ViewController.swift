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
import SCLAlertView


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet public var WeatherText: UILabel!
    
    @IBOutlet weak var WeatherDescription: UILabel!
    
    let locationManager = CLLocationManager()
    
    var stationTest = WeatherManager()
    
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

    }
    

    //func locationHasBeenUpdated() {
        //stationTest.updateCurrent()
    //}
    
    override func viewDidAppear(_ animated: Bool) {
        //progress
        //showInputView()
        showWarning(title: "Station Limit!", subTitle: "You may not have more than 6 stations. Currently we cannot afford for each user to have 6 stations.😕 You can help us reach our goal of $2,500 by going to our site: nexal.net This will give us the funding we need to add features to the app and make users have more that 6 stations!")
        startLoadingScreen("")
        
        //things to run when the application is opened for the first time!
        //if firstOpen() {
           // runAtFirstOpen()
        //}
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        global.userLocation.latitude = locValue.latitude
        global.userLocation.longitude = locValue.longitude
        
        //Location uptdated call
        
        //weather test UI

        
        //stop loading screen after location data is populated
        stopLoadingScreen()
        
        print("\(global.userLocation.latitude), \(global.userLocation.longitude) :")
        
        if global.userLocation.latitude != 0.0 && global.userLocation.longitude != 0.0 {
            
            global.locationAvalible = true
            locationHasBeenUpdated()
            
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
    
    @IBAction func Populateweatherdata(_ sender: UIButton) {
        stationTest.updateCurrentStationCurrent()
    }
    
    @IBAction func PrintWeatherData(_ sender: UIButton) {
        print("-----------------------")
        print("\(stationTest.stations[0].currentWeather?.clouds)")
        print("-----------------------")
    }
    
    
}
