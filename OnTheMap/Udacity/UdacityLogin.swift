//
//  UdacityLogin.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation


struct UdacityLogin {
  let userID: String
  let sessionID: String
  
  init(dictionary: [String:AnyObject]) {
    if let account = dictionary["account"] {
      userID = account["key"] as! String
    } else {
      userID = ""
    }
    if let session = dictionary["session"] {
      sessionID = session["id"] as! String
    } else {
      sessionID = ""
    }
  }
  
}
