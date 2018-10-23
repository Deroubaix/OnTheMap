//
//  BaseClient.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

class BaseClient : NSObject {
  
  func createURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil, scheme:String, host: String, path: String) -> URL {
    
    var components = URLComponents()
    components.scheme = scheme
    components.host = host
    components.path = path + (withPathExtension ?? "")
    components.queryItems = [URLQueryItem]()
    
    for (key, value) in parameters {
      let queryItem = URLQueryItem(name: key, value: "\(value)")
      components.queryItems!.append(queryItem)
    }
    
    return components.url!
  }
  
}

