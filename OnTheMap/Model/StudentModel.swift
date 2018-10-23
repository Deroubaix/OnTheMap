//
//  StudentModel.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

class StudentModel {
  
  var studentLocations : [StudentLocation]?
  
  static let sharedInstance = StudentModel()
  
  init() {}
  
}
