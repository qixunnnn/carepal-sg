//
//  MapsViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 28/1/21.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var location: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }
        //Zoom to user location
           if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
               mapView.setRegion(viewRegion, animated: false)
           }

          
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("535 Clementi Road Singapore 599489", completionHandler:
            {(p,e) in
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: p![0].location!.coordinate.latitude, longitude: p![0].location!.coordinate.longitude)
                annotation.title = "Ngee Ann Polytechnic"
                self.mapView.addAnnotation(annotation)
      
            })
     
        
        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

//        mapView.mapType = MKMapType.standard
//
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = locValue
//        annotation.title = "Me"
//        annotation.subtitle = "current location"
//        mapView.addAnnotation(annotation)
        self.location = locations.last as CLLocation?

        //centerMap(locValue)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
