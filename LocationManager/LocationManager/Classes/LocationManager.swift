//
//  LocationManagerSingleton.swift
//  Tadbeer
//
//  Created by Shahbaz Khan on 12/22/19.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import CoreLocation

open class LocationManager: NSObject, CLLocationManagerDelegate {
    var isLocationOn : Bool = false
    var locationManager : CLLocationManager?
    var currentLocationPoint : CLLocationCoordinate2D!
    
    public static let shared : LocationManager = {
        
        let instance = LocationManager()
        return instance
    }()
    
    
    override init() {
        super.init()
        self.currentLocationPoint = CLLocationCoordinate2D()
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.enableLocation()
    }
    
    //MARK: LocationManagerSingleton Methods
    private func enableLocation()  {
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    func checkLocationManager() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .denied {
                return false
                
            }  else {
                return true
            }
            
        } else {
            return false
        }
    }
    
    
    func checkLocationManagerIfChanged()  {
        if self.checkLocationManager() {
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: "LocationOn"),
                object: nil)
        } else {
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: "LocationOff"),
                object: nil)
        }
    }
    
    //MARK: CLLocationManagerDelegate Methods
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.isLocationOn = self.checkLocationManager()
        self.currentLocationPoint = locations[0].coordinate
        if self.isLocationOn {
            
        } else {
            self.currentLocationPoint.latitude = 24.4667
            self.currentLocationPoint.longitude = 54.3667
            
            
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.isLocationOn = false;
        self.currentLocationPoint.latitude = 24.4667;
        self.currentLocationPoint.longitude = 54.3667;
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.isLocationOn = false;
        if status  == .authorizedWhenInUse {
            self.isLocationOn = true;
        }
        
    }
    
    public func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        self.isLocationOn = false;
        
    }
    
    public func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        self.isLocationOn = true;
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        self.isLocationOn = false;
        
    }
    
}
