//
//  MapsViewController.swift
//  carepal@sgapp
//
//  Created by Yip jun wei on 28/1/21.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var stepLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var calculatingRLbl: UILabel!
    var previousLocation : CLLocation!
    let locationManager = CLLocationManager()
    let np = CLLocationCoordinate2D(latitude: 1.333498666, longitude: 103.772830242)
    var destination = CLLocationCoordinate2D.init()
    var tapped = false
    var location: CLLocation!
    public var currentCoordinates: CLLocationCoordinate2D!
    var directionsArray: [MKDirections] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        calculatingRLbl.isHidden = true
        overrideUserInterfaceStyle = .light
        mapView.delegate = self
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .followWithHeading
        }
       // let span: MKCoordinateSpan = MKCoordinateSpanMake(0.3, 0.3)
            
        //Zoom to user location
//           if let userLocation = locationManager.location?.coordinate {
//            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
//               mapView.setRegion(viewRegion, animated: false)
//           }

      
        let geocoder = CLGeocoder()
        let annotation = MKPointAnnotation()
        geocoder.geocodeAddressString("535 Clementi Road Singapore 599489", completionHandler:
            {(p,e) in
                let coordinates = CLLocationCoordinate2D(latitude: p![0].location!.coordinate.latitude, longitude: p![0].location!.coordinate.longitude)
                annotation.coordinate = coordinates
                annotation.title = "Ngee Ann Polytechnic"
                annotation.subtitle = "535 Clementi Road Singapore 599489"
                self.mapView.addAnnotation(annotation)
                
            })
        
        
       
        // Do any additional setup after loading the view.
    }
   
    @IBAction func centerMapOnUserLocation(_ sender: Any) {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let region = MKCoordinateRegion(center:coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!,fromLocation oldLocation: CLLocation!)
    {
       
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let locValue:CLLocationCoordinate2D = manager.location!.coordinate

//        mapView.mapType = MKMapType.standard
//
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = locValue
//        annotation.title = "Me"
//        annotation.subtitle = "current location"
//        mapView.addAnnotation(annotation)
        guard let currentlocation = locations.last else {return}
        location = currentlocation
        if(tapped)
        {
            if let previousLocationNew = previousLocation as CLLocation?
            {
                //case if previous location exists
               
                if previousLocation.distance(from: currentlocation) > 10 {
                   //show route
                    
                        showRouteOnMap(pickupCoordinate: currentlocation.coordinate, destinationCoordinate: destination)
                        
                    previousLocation = currentlocation
                }
            }
            else{
                //in case previous location doesn't exist
                //show route
               
                    showRouteOnMap(pickupCoordinate: currentlocation.coordinate, destinationCoordinate: destination)
                   
                previousLocation = currentlocation
            }
            
        }
        
        
        mapView.userTrackingMode = .followWithHeading
        //centerMap(locValue)
    }
  
    
    func resetMapView(withNew directions:MKDirections)
    {
        mapView.removeOverlays(mapView.overlays)
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        tapped = true
        destination = np
        calculatingRLbl.isHidden = false
        activityIndicator.startAnimating()
        
       // print(view.annotation?.title!!)
        //print(view.annotation?.subtitle!!)
    }
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
            request.requestsAlternateRoutes = true
            request.transportType = .automobile

            let directions = MKDirections(request: request)
            resetMapView(withNew: directions)

            directions.calculate { [unowned self] response, error in
                guard let unwrappedResponse = response else { return }
                
                //for getting just one route
                if let route = unwrappedResponse.routes.first {
                    let step = route.steps[1]
                    let distance = String(format:"%.2f", step.distance)
                    stepLbl.text = "In \(distance)meters \(step.instructions)"
                    route.expectedTravelTime/60
                    //show on map
                    
                    self.mapView.addOverlay(route.polyline)
                    //set the map area to show the route
                    self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
                    calculatingRLbl.isHidden = true
                    activityIndicator.stopAnimating()
                }

                //if you want to show multiple routes then you can get all routes in a loop in the following statement
                //for route in unwrappedResponse.routes {}
            }
        }
    //this delegate function is for displaying the route overlay and styling it
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = UIColor.systemBlue
         renderer.lineWidth = 5.0
         return renderer
    }

  

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }

        let reuseIdentifier = "..."

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}
class CustomAnnotationView: MKPinAnnotationView {  // or nowadays, you might use MKMarkerAnnotationView
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        canShowCallout = true
        rightCalloutAccessoryView = UIButton(type: .contactAdd)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
