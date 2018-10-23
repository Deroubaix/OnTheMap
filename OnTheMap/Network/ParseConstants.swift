//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

extension ParseClient {
  
  struct Constants {
    // MARK: URLs
    static let apiScheme = "https"
    static let apiHost = "parse.udacity.com"
    static let apiPath = "/parse/classes"
  }
  
  struct Methods {
    static let studentLocations = "/StudentLocation"
  }
  
  struct ParameterKeys {
    static let limit = "limit"
    static let whereKey = "where"
    static let order = "order"
  }
  
  struct ParameterValues {
    static let limit = "100"
    static let order = "-updatedAt"
  }
  
  struct HeaderKeys {
    static let applicationId = "X-Parse-Application-Id"
    static let restApi = "X-Parse-REST-API-Key"
    static let contentType = "Content-Type"
  }
  
  struct HeaderValues {
    static let applicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let restApi = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    static let contentType = "application/json"
  }
  
}
