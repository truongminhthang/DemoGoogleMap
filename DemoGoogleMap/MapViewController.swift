//
//  ViewController.swift
//  DemoGoogleMap
//
//  Created by Thang Hoa on 12/18/18.
//  Copyright © 2018 Thang Hoa. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlacePicker


class MapViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView! {
        didSet {
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    var likelyPlaces: [GMSPlace] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
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
    
    @IBAction func pickPlace(_ sender: UIButton) {
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker =  GMSPlacePickerViewController(config: config)
        present(placePicker, animated: true, completion: nil)
    }
    
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {return}
        let camera = GMSCameraPosition.camera(withTarget: lastLocation.coordinate, zoom: 15)
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
//    func listLikelyPlaces() {
//        likelyPlaces = []
//        GMSPlacesClient.shared().currentPlace { (placeLikelihood, error) in
//            guard error == nil, placeLikelihood != nil  else {
//                print("Current place error: \(error!.localizedDescription)")
//                return
//            }
//            
//            self.likelyPlaces = placeLikelihood!.likelihoods.map({ (likelihood) -> GMSPlace in
//                likelihood.place
//            })
//        }
//        
//    }
}

// MARK: - <#Mark#>

//extension MapViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return likelyPlaces.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = likelyPlaces[indexPath.row].addressComponents?.reduce("", { (result, address) -> String in
//            return result + " \(address)"
//        })
//        return cell
//    }
//}



