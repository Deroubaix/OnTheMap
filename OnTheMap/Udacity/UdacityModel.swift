//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

extension UdacityClient {
  struct Constants {
    // MARK: URLs
    static let apiScheme = "https"
    static let apiHost = "www.udacity.com"
    static let apiPath = "/api"
  }
  
  struct Methods {
    static let session = "/session"
    static let user = "/users"
  }
}
