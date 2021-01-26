////
////  MapViewController.swift
////  
////
////  Created by Yip jun wei on 7/1/21.
////
//
//import UIKit
//import MapKit
//import CoreLocation
////import GoogleMaps
//
//class MapViewController: UIViewController, CLLocationManagerDelegate {
//
//    @IBOutlet weak var infobarV: UIView!
//    //@IBOutlet weak var mapView: MKMapView!
//    var locationManager : CLLocationManager!
//    var mapView: GMSMapView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        infobarV.layer.shadowColor = UIColor.black.cgColor
//        infobarV.layer.shadowOpacity = 0.5
//        infobarV.layer.shadowOffset = .zero
//        infobarV.layer.shadowRadius = 5
//        infobarV.layer.cornerRadius = 5
//        // Ask for Authorisation from the User.
//       // self.locationManager.requestAlwaysAuthorization()
//
//        // For use in foreground
//       // self.locationManager.requestWhenInUseAuthorization()
///*
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
// */
//        GoogleMapsHelper.initLocationManager(locationManager, delegate: self)
//        GoogleMapsHelper.createMap(on: view, locationManager: locationManager, mapView: mapView)
//       
//        
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString("535 Clementi Road Singapore 599489", completionHandler:
//            {(p,e) in
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = CLLocationCoordinate2D(latitude: p![0].location!.coordinate.latitude, longitude: p![0].location!.coordinate.longitude)
//                annotation.title = "Ngee Ann Polytechnic"
//                // self.mapView.addAnnotation(annotation)
//                let la = p![0].location!.coordinate.latitude
//                let lo = p![0].location!.coordinate.longitude
//                
//                //let camera = GMSCameraPosition.camera(withLatitude: la, longitude: lo, zoom: 6.0)
//                //let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
//               // self.view.addSubview(mapView)
//                
//                let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2D(latitude: la, longitude: lo)
//                marker.title = "Ngee Ann Polytechnic"
//                marker.snippet = "Singapore"
//                marker.map = self.mapView
//            })
//     
//        
//        // Do any additional setup after loading the view.
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//      
//        mapView.clear()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//       
//        GoogleMapsHelper.didUpdateLocations(locations, locationManager: locationManager, mapView: mapView)
//    }
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//
//        GoogleMapsHelper.handle(manager, didChangeAuthorization: status)
//    }
//    
//    // Handle location manager errors.
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationManager.stopUpdatingLocation()
//        print("Error: \(error)")
//    }
//
//    /*
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//
//        mapView.mapType = MKMapType.standard
//
//       
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = locValue
//        annotation.title = "Me"
//        annotation.subtitle = "current location"
//        mapView.addAnnotation(annotation)
//
//        //centerMap(locValue)
//    }
// */
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
