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
    let jp = CLLocationCoordinate2D(latitude: 1.3400319732, longitude: 103.704087184)
    var newLocation = false
    var destination = CLLocationCoordinate2D.init()
    var tapped = false
    var location: CLLocation!
    public var currentCoordinates: CLLocationCoordinate2D!
    
    let annoCoordinates: Array<CLLocationCoordinate2D> =
        [CLLocationCoordinate2D(latitude: 1.3485, longitude: 103.7115),//boon lay cc,
         CLLocationCoordinate2D(latitude: 1.3189, longitude: 103.7681),//clementi cc
         CLLocationCoordinate2D(latitude: 1.3401, longitude: 103.7372)//clementi cc
        ]
    let annoTitle: Array<String> =
        ["Boon lay CC",
        "Clementi CC",
        "Yuhua CC"]
    let annoSubtitle: Array<String> =
        ["10 Boon Lay Pl Singapore 649882",
        "220 Clementi Ave 4 Singapore 129880",
        "90 Boon Lay Way Singapore 609958"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        calculatingRLbl.isHidden = true
        overrideUserInterfaceStyle = .light
   
       
        
        //map
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
        
       
        var c = 0
        for i in annoCoordinates
        {
            let annotation = MKPointAnnotation()
            annotation.coordinate = i
            annotation.title = annoTitle[c]
            annotation.subtitle = annoSubtitle[c]
            mapView.addAnnotation(annotation)
            c+=1
        }
    
        
        
      /*
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("535 Clementi Road Singapore 599489", completionHandler:
            {(p,e) in
                let coordinates = CLLocationCoordinate2D(latitude: p![0].location!.coordinate.latitude, longitude: p![0].location!.coordinate.longitude)
                annotation.coordinate = coordinates
                annotation.title = "Ngee Ann Polytechnic"
                annotation.subtitle = "535 Clementi Road Singapore 599489"
                self.mapView.addAnnotation(annotation)
                
            })
 
        */
        
        
    }
    
    //go to current location btn
    @IBAction func centerMapOnUserLocation(_ sender: Any) {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let region = MKCoordinateRegion(center:coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.userTrackingMode = .followWithHeading
        mapView.setRegion(region, animated: true)
    }
    
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        mapView.mapType = MKMapType.standard

        guard let currentlocation = locations.last else {return}
        location = currentlocation
        if(tapped)
        {
            if (previousLocation != nil)
            {
                //case if previous location exists
               
                if previousLocation.distance(from: currentlocation) > 10 {
                   //show route
                        mapView.userTrackingMode = .followWithHeading
                        showRouteOnMap(pickupCoordinate: currentlocation.coordinate, destinationCoordinate: destination)
                        
                    previousLocation = currentlocation
                }
            }
            else{
                //in case previous location doesn't exist
                //show route
                mapView.userTrackingMode = .followWithHeading
                    showRouteOnMap(pickupCoordinate: currentlocation.coordinate, destinationCoordinate: destination)
                   
                previousLocation = currentlocation
            }
            
        }
        
        
       
    }
  
    //to clear route
    func resetMapView(withNew directions:MKDirections)
    {
        mapView.removeOverlays(mapView.overlays)
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        tapped = true
        newLocation = true
        calculatingRLbl.isHidden = false
        activityIndicator.startAnimating()
        self.destination = view.annotation!.coordinate
        previousLocation = nil
        

    }
    //create route
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
                    stepLbl.text = "In \(distance)m \(step.instructions)"
                    timeLbl.text = String(format:"ETA: %.2fmin",route.expectedTravelTime/60)
                    
                    //show on map
                    
                    self.mapView.addOverlay(route.polyline)
                    //set the map area to show the route
                    if(newLocation)
                    {
                        self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
                        newLocation = false
                    }
                    
                    calculatingRLbl.isHidden = true
                    activityIndicator.stopAnimating()
                }

               
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

        let reuseIdentifier = "."

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
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
