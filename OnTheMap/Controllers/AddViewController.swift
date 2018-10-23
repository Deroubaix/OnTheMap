//
//  AddViewController.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AddViewController : UIViewController {
  let geoCoder: CLGeocoder = CLGeocoder()
  
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var urlTextField: UITextField!
  
  @IBAction func dismissViewController(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func findLocation(_ sender: Any) {
    let errorMessage = checkFields()
    if errorMessage.isEmpty {
//      showActivityIndicator()
      searchLocationFromString(locationTextField.text ?? "")
    } else {
      presentErrorAlertController(title: "Required field", errorMessage: errorMessage, buttonText: "Ok")
    }
  }
  
  //MARK: Private methods
  
  private func searchLocationFromString(_ locationAsString: String) {
    geoCoder.geocodeAddressString(locationAsString) { (placemarks, error) in
      guard
        let placemarks = placemarks,
        let location = placemarks.first?.location
        else {
          performUIUpdatesOnMain {
//            self.hideActivityIndicator()
            self.showNoLocationError()
          }
          return
      }
      
      // Use your location
      self.lookUpCurrentLocation(location)
    }
  }
  
  private func lookUpCurrentLocation(_ location: CLLocation?) {
    // Use the last reported location.
    if let lastLocation = location {
      // Look up the location and pass it to the completion handler
      geoCoder.reverseGeocodeLocation(lastLocation,
                                      completionHandler: { (placemarks, error) in
                                        if error == nil {
//                                          self.hideActivityIndicator()
                                          let firstLocation = placemarks?[0]
                                          self.performSegue(withIdentifier: "SubmitViewController", sender: firstLocation)
                                        }
                                        else {
                                          //show location error
                                          performUIUpdatesOnMain {
                                            self.showNoLocationError()
                                          }
                                        }
      })
    }
  }
  
  private func showNoLocationError() {
    presentErrorAlertController(title: "Error", errorMessage: "No location found for this text", buttonText: "Ok")
  }
  
  private func checkFields() -> String {
    let location = locationTextField.text
    let url = urlTextField.text
    var result: String?
    if (location?.isEmpty)! {
      result = "Username required"
    } else if (url?.isEmpty)! {
      result = "Password required"
    }
    return result ?? ""
  }
  
    func presentErrorAlertController(title: String, errorMessage: String, buttonText: String) {
      let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: buttonText, style: .default, handler: nil)
      alert.addAction(alertAction)
      present(alert, animated: true, completion: nil)
    }
  
  //MARK: prepare segue
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SubmitViewController" {
      if let placemark = sender as? CLPlacemark {
        let locationDetailViewController = segue.destination as! SubmitViewController
        locationDetailViewController.placemark = placemark
        locationDetailViewController.mediaUrl = urlTextField.text!
      }
    }
  }
  
}
