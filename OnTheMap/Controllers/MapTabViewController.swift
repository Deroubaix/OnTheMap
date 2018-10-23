//
//  MapTabViewController.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapTabViewController : DetailsViewController, CLLocationManagerDelegate, DataCompletionListener {
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    super.delegate = self
    mapView.delegate = self
    if let _ = StudentModel.sharedInstance.studentLocations?.count {
      onRetriveStudentLocationSuccess()
    } else {
      super.retrieveLocations(self)
    }
  }
  
  //MARK - Delegate
  func onRetriveStudentLocationSuccess() {
    performUIUpdatesOnMain {
      self.mapView.removeAnnotations(self.mapView.annotations)
      for location in StudentModel.sharedInstance.studentLocations! {
        self.mapView.addAnnotation(Annotation(title: "\(location.firstName) \(location.lastName)", url: location.mediaUrl, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
      }
    }
  }
  
  func onDataLoadFailure(_ error: NSError) {
    presentErrorAlertController(title: "Error", errorMessage: error.localizedDescription, buttonText: "Ok")
  }
  
  override func presentErrorAlertController(title: String, errorMessage: String, buttonText: String) {
    let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: buttonText, style: .default, handler: nil)
    alert.addAction(alertAction)
    present(alert, animated: true, completion: nil)
  }
  
}

extension MapTabViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
  
    guard let annotation = annotation as? Annotation else { return nil }
    
    let identifier = "marker"
    var view: MKMarkerAnnotationView
    
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    let annotation = view.annotation as! Annotation
    guard let url = URL(string: annotation.url) else {
      return //be safe
    }
    openUrl(url)
  }
}

