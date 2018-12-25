//
//  ViewController.swift
//  DemoGoogleMap
//
//  Created by Thang Hoa on 12/18/18.
//  Copyright © 2018 Thang Hoa. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class MapViewController: UIViewController {
    @IBOutlet weak var getPlacesButton: UIBarButtonItem!
    @IBOutlet weak var mapView: GMSMapView! {
        didSet {
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 400
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.allowsBackgroundLocationUpdates = true
    }
    

}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {return}
        let camera = GMSCameraPosition.camera(withTarget: lastLocation.coordinate, zoom: 15)
//        mapView.camera = camera
        mapView.animate(to: camera)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted, .denied, .authorizedWhenInUse:
            showAlertToOpenSetting(title: "Cấp quyền truy cập Vị trí", message: "Chúng tôi cần vị trí của bạn để thực hiện các nhiệm vụ của app")
        case .authorizedAlways:
            break
        }
    }
}



