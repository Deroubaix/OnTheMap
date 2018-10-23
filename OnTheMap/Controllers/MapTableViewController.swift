//
//  MapTableViewController.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation
import UIKit

class MapTableViewController : DetailsViewController, DataCompletionListener {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    super.delegate = self
    tableView.delegate =  self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.reloadData()
    if let _ = StudentModel.sharedInstance.studentLocations?.count {
      onRetriveStudentLocationSuccess()
    } else {
      super.retrieveLocations(self)
    }
  }
  
  //MARK: Delegate
  func onRetriveStudentLocationSuccess() {
    performUIUpdatesOnMain {
      self.tableView.reloadData()
    }
  }
  
  func onDataLoadFailure(_ error: NSError) {
    presentErrorAlertController(title: "Error", errorMessage: error.localizedDescription, buttonText: "Ok")
  }
  
}

extension MapTableViewController : UITableViewDelegate, UITableViewDataSource {

  //MARK: Tableview delegates

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let rowsCount = StudentModel.sharedInstance.studentLocations?.count else {
      return 0;
    }
    return rowsCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
    cell.textLabel?.text = "\(StudentModel.sharedInstance.studentLocations![indexPath.row].firstName) \(StudentModel.sharedInstance.studentLocations![indexPath.row].lastName)"
    cell.detailTextLabel?.text = "\(StudentModel.sharedInstance.studentLocations![indexPath.row].mediaUrl)"
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let url = StudentModel.sharedInstance.studentLocations![indexPath.row].mediaUrl
    openUrl(URL(string: url)!)
  }


}

