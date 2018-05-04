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
import SCLAlertView


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
//in the name
func doubleToString(_ input: Double) -> String {
    return String(format:"%f", input)
}



func debug(_ output: String) {
    if global.debug == true {
        print(output)
    }
}

//var stationTest = WeatherManager()
//called every time location is updated
func locationHasBeenUpdated() {
    
    //stationTest.updateCurrentStationCurrent()
    
    
    print("location updated")
}

//User interface notiification functions.
func showWarning(title: String, subTitle: String) {
    _ = SCLAlertView().showWarning(title, subTitle: subTitle)
}

func showInfo(title: String, subTitle: String) {
    _ = SCLAlertView().showInfo(title, subTitle: subTitle)
}

func showError(title: String, subTitle: String) {
    _ = SCLAlertView().showError(title, subTitle: subTitle)
}

func showInputView() -> (fname: String, lname: String) {
    // Create custom Appearance Configuration
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false,
        dynamicAnimatorActive: true
    )
    
    // Initialize SCLAlertView using custom Appearance
    let alert = SCLAlertView(appearance: appearance)
    
    // Creat the subview
    let subview = UIView(frame: CGRect(x: 0,y: 0,width: 216,height: 70))
    let x = (subview.frame.width - 180) / 2
    
    // Add textfield 1
    let textfield1 = UITextField(frame: CGRect(x: x,y: 10,width: 180,height: 25))
    textfield1.layer.borderColor = UIColor.green.cgColor
    //textfield1.layer.borderWidth = 1.5
    //textfield1.layer.cornerRadius = 5
    textfield1.placeholder = "First Name"
    textfield1.textAlignment = NSTextAlignment.center
    subview.addSubview(textfield1)
    
    // Add textfield 2
    let textfield2 = UITextField(frame: CGRect(x: x,y: textfield1.frame.maxY + 10,width: 180,height: 25))
    //textfield2.isSecureTextEntry = true
    //textfield2.layer.borderColor = UIColor.blue.cgColor
    //textfield2.layer.borderWidth = 1.5
    textfield2.layer.cornerRadius = 5
    textfield1.layer.borderColor = UIColor.blue.cgColor
    textfield2.placeholder = "Last Name"
    textfield2.textAlignment = NSTextAlignment.center
    subview.addSubview(textfield2)
    
    
    // Add the subview to the alert's UI property
    alert.customSubview = subview
    _ = alert.addButton("Login") {
        print("Logged in")
    }
    
    _ = alert.showInfo("Login", subTitle: "")
    return (textfield1.text!, textfield2.text!)
    
    //print("\(textfield1.text)**************************************************************************************")
}

//things to run when the application is opened for the first time!
func runAtFirstOpen() {
    
    showInputView()
    
    
}

