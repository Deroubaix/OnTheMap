//
//  SaveLocation.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

struct SaveLocation {
  let objectId: String
  let createdDate: String
  
  init(dictionary: [String: AnyObject]) {
    if let _objectId = dictionary["objectId"] {
      objectId = _objectId as! String
    } else {
      objectId = ""
    }
    if let _createdDate = dictionary["createdDate"] {
      createdDate = _createdDate as! String
    } else {
      createdDate = ""
    }
  }
}
