//
//  StudentLocationResponse.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

struct StudentLocationsResponse {
  
  var studentLocations: [StudentLocation]
  
  init(jsonDictionary: [String: AnyObject]) {
    if let results = jsonDictionary["results"] as? [AnyObject] {
      studentLocations = [StudentLocation]()
      for result in results {
        guard let studentLocation = result as? [String : AnyObject] else {
          return
        }
        studentLocations.append(StudentLocation(jsonDictionary: studentLocation))
      }
    } else {
      studentLocations = [StudentLocation]()
    }
  }
}
