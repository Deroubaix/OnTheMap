//
//  NetworkUdacity.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

extension UdacityClient {
  func login(username: String, password: String, completionForLogin: @escaping (_ result: UdacityLogin?, _ error: NSError?) -> Void) {
    
    /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
    let method: String = UdacityClient.Methods.session
    let jsonBody: String = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
    
    /* 2. Make the request */
    let _ = taskForPOSTMethod(method, parameters: [String : AnyObject](), jsonBody: jsonBody) {
      (response, error) in
      
      /* 3. Send the desired value(s) to completion handler */
      if let error = error {
        completionForLogin(nil, error)
      } else {
        let loginResponse = UdacityLogin(dictionary: response as! [String : AnyObject])
        completionForLogin(loginResponse, nil)
      }
      
    }
    
  }
  
  func retrieveUserInformation(_ userId: String, completionForRetrieveUserInfo: @escaping (_ result: UserInfoResponse?, _ error: NSError?) -> Void) {
    
    /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
    let method: String = "\(UdacityClient.Methods.user)/\(userId)"
    
    /* 2. Make the request */
    let _ = taskForGETMethod(method, [:]) {
      (response, error) in
      
      /* 3. Send the desired value(s) to completion handler */
      if let error = error {
        completionForRetrieveUserInfo(nil, error)
      } else {
        let userInfoResponse = UserInfoResponse(dictionary: response as! [String : AnyObject])
        completionForRetrieveUserInfo(userInfoResponse, nil)
      }
      
    }
    
  }
  
  func logout(completionForLogout: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
    /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
    let method: String = UdacityClient.Methods.session
    
    /* 2. Make the request */
    let _ = taskForDELETEMethod(method, [:]){
      (response, error) in
      
      /* 3. Send the desired value(s) to completion handler */
      if let error = error {
        completionForLogout(nil, error)
      } else {
        completionForLogout(response, nil)
      }
    }
  }
  
}
