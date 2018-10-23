//
//  UserInfo.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

class UserInfo : NSObject {
  
  var userId: String?
  var sessionId: String?
  var firstName: String?
  var lastName: String?
  var locationId: String?
  
  // MARK: Singleton
  
  static let sharedInstance = UserInfo()
  
}
