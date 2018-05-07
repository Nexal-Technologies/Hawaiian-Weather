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
import SkeletonView



class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet public var WeatherText: UILabel!
    
    @IBOutlet weak var WeatherDescription: UILabel!
    
    let locationManager = CLLocationManager()
    
    var weatherManager = WeatherManager()
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            //self.weatherManager = WeatherManager()
            self.weatherManager.updateCurrentStationCurrent()
        })
        
    }
    

    //func locationHasBeenUpdated() {
        //stationTest.updateCurrent()
    //}
    
    override func viewDidAppear(_ animated: Bool) {
        //progress
        //showInputView()
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
        weatherManager.updateCurrentStationCurrent()
    }
    
    @IBAction func PrintWeatherData(_ sender: UIButton) {
        print("-----------------------")
        print("\(weatherManager.stations[0].currentWeather?.clouds)")
        print("-----------------------")
    }
    
    func updateUI() {
        print(weatherManager.stations.count)
//        for i in 0...(weatherManager.stations.count - 1) { //checks if any stations are not set
//            if weatherManager.stations[i].currentWeather?.weather[0].main == nil {
//                //failed to update
//                stopLoadingScreen()
//                showError(title: "Couldn't update weather data!", subTitle: "Please check your connection. The weather is updated automaticaly.")
//                return
//            }
//            if i == 0 { // beaks the loop or else it will keep going if there are 0
//                break
//            }
//        }
        //showInfo(title: "Sucess", subTitle: "Sucess grabing data!")
        // updating the UI
        print("instead of the notification SUCSESS")
        
        
        stopLoadingScreen()
    }
}
