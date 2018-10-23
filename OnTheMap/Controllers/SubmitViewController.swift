//
//  SubmitViewController.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class SubmitViewController : UIViewController, CLLocationManagerDelegate {
  
  var placemark: CLPlacemark!
  var mediaUrl: String!
  
  var latitude: Double!
  var longitude: Double!
  var mapString: String!
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    latitude = (placemark.location?.coordinate.latitude)!
    longitude = (placemark.location?.coordinate.longitude)!
    mapString = "\(placemark.administrativeArea ?? "") \(placemark.country ?? "")"
    
    mapView.addAnnotation(Annotation(title: mapString, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
    
    let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    mapView.setRegion(region, animated: true)
    
  }
  
  func presentErrorAlertController(title: String, errorMessage: String, buttonText: String) {
      let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: buttonText, style: .default, handler: nil)
      alert.addAction(alertAction)
      present(alert, animated: true, completion: nil)
    }
  
  @IBAction func saveStudentLocation(_ sender: Any) {
    let objectId = UserInfo.sharedInstance.locationId ?? ""
    let userId = UserInfo.sharedInstance.userId ?? ""
    let firstName = UserInfo.sharedInstance.firstName ?? ""
    let lastName = UserInfo.sharedInstance.lastName ?? ""
    
//    showActivityIndicator()
    ParseClient.sharedInstance.saveStudentLocation(objectId, userId, firstName, lastName, mapString, mediaUrl, latitude, longitude) {
      (response, error) in
      performUIUpdatesOnMain {
//        self.hideActivityIndicator()
        if let error = error {
          self.presentErrorAlertController(title: "Error", errorMessage: error.localizedDescription, buttonText: "Ok")
        } else {
          self.navigationController?.dismiss(animated: true, completion: nil)
        }
      }
    }
  }
  
}

extension SubmitViewController : MKMapViewDelegate {
  // 1
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    // 2
    guard let annotation = annotation as? Annotation else { return nil }
    // 3
    let identifier = "marker"
    var view: MKMarkerAnnotationView
    // 4
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      // 5
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
  }
}

