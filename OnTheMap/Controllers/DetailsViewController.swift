//
//  DetailsViewController.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController : UIViewController {
  
  var delegate: DataCompletionListener!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  @IBAction func logout(_ sender: Any) {
    UdacityClient.sharedInstance.logout() {
      (response, error) in
      performUIUpdatesOnMain {
        if let error = error {
          // For Logging
          self.presentErrorAlertController(title: "Error", errorMessage: error.localizedDescription, buttonText: "Ok")
        } else {
          // For Logging
          self.dismiss(animated: true, completion: nil)
        }
      }
    }
  }
  
  
  @IBAction func retrieveLocations(_ sender: Any) {
    
    ParseClient.sharedInstance.retrieveStudentLocations({
      [weak self] (locations, error) in
      if let error = error {
        self?.delegate.onDataLoadFailure(error)
      } else {
        if let studentLocations = locations?.studentLocations {
          StudentModel.sharedInstance.studentLocations = studentLocations
          self?.delegate.onRetriveStudentLocationSuccess()
        }
      }
    })
  }
  
  
  
  @IBAction func addStudentLocation(_ sender: Any) {
    checkIfUserHasLocations()
  }
  
  
  private func checkIfUserHasLocations() {

    ParseClient.sharedInstance.retrieveStudentLocation(UserInfo.sharedInstance.userId ?? ""){
      [unowned self] (locations, error) in
      if let error = error {
        self.presentErrorAlertController(title: "Error checking user locations", errorMessage: error.localizedDescription, buttonText: "Ok")
      } else {
        if let studentLocations = locations?.studentLocations {
          if (studentLocations.count > 0) {
            UserInfo.sharedInstance.locationId = studentLocations.first?.objectId
            self.presentAlreadyHasLocationErrorAlertController()
          } else {
            performUIUpdatesOnMain {
              self.showAddLocationViewController()
            }
          }
        }
      }
    }
  }
  
  func openUrl(_ url: URL) {
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
  
  private func presentAlreadyHasLocationErrorAlertController() {
    let alert = UIAlertController(title: "Alert", message: "You already have a location saved. Do you want to overwrite it?", preferredStyle: .alert)
    let overwriteAction = UIAlertAction(title: "Overwrite", style: .default, handler: {action in
      self.showAddLocationViewController()
    })
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alert.addAction(overwriteAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
  private func showAddLocationViewController() {
    self.performSegue(withIdentifier: "AddLocationViewController", sender: self)
  }
  
  func presentErrorAlertController(title: String, errorMessage: String, buttonText: String) {
    let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: buttonText, style: .default, handler: nil)
    alert.addAction(alertAction)
    self.present(alert, animated: true, completion: nil)
  }
  
}

