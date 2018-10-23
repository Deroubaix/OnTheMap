//
//  UserInfoResponse.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

struct UserInfoResponse {
  
  let firstName: String
  let lastName: String
  
  init(dictionary: [String : AnyObject]) {
    if let user = dictionary["user"] {
      if let _firstName = user["first_name"] {
        firstName = _firstName as! String
      } else {
        firstName = ""
      }
      if let _lastName = user["last_name"] {
        lastName = _lastName as! String
      } else {
        lastName = ""
      }
    } else {
      firstName = ""
      lastName = ""
    }
  }
  
}
