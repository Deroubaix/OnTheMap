//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

class UdacityClient : BaseClient {
  let session = URLSession.shared
  
  var userID: String? = nil
  var sessionID: String? = nil
  
  // MARK: Singleton
  
  static let sharedInstance = UdacityClient()
  
  // MARK: Initializers
  
  override init() {
    super.init()
  }
  
  
  func taskForPOSTMethod(_ method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
    
    /* 1. Set the parameters */
    
    /* 2/3. Build the URL, Configure the request */
    let request = NSMutableURLRequest(url: createURLFromParameters(parameters, withPathExtension: method, scheme: Constants.apiScheme, host: Constants.apiHost, path: Constants.apiPath))
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonBody.data(using: String.Encoding.utf8)
    
    /* 4. Make the request */
    let task = session.dataTask(with: request as URLRequest, completionHandler: {
      (data, response, error) in
      
      func sendError(_ error: String) {
        let userInfo = [NSLocalizedDescriptionKey : error]
        completionHandlerForPOST(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
      }
      
      /* GUARD: Was there an error> */
      guard (error == nil) else {
        sendError("There was an error with your request: \(error!.localizedDescription)")
        return
      }
      
      /* GUARD: Was there any data returned? */
      guard let data = data else {
        sendError("No data was returned by the request!")
        return
      }
      
      /* GUARD: Did we get a successful 2XX response? */
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
        self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
        return
      }
      
      /* 5/6. Parse the data and use the data (happens in completion handler) */
      self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
      
    })
    
    /* 7. Start the request */
    task.resume()
    
    return task
  }
  
  func taskForGETMethod(_ method : String, _ parameters : [String:AnyObject], completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
    
    /* 1. Set the parameters */
    
    /* 2/3. Build the URL, Configure the request */
    let request = NSMutableURLRequest(url: createURLFromParameters(parameters, withPathExtension: method, scheme: Constants.apiScheme, host: Constants.apiHost, path: Constants.apiPath))
    
    /* 4. Make the request */
    let task = session.dataTask(with: request as URLRequest, completionHandler: {
      (data, response, error) in
      
      func sendError(_ error: String) {
        let userInfo = [NSLocalizedDescriptionKey : error]
        completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
      }
      
      /* GUARD: Was there an error> */
      guard (error == nil) else {
        sendError("There was an error with your request: \(error!.localizedDescription)")
        return
      }
      
      /* GUARD: Was there any data returned? */
      guard let data = data else {
        sendError("No data was returned by the request!")
        return
      }
      
      /* GUARD: Did we get a successful 2XX response? */
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
        self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        return
      }
      
      /* 5/6. Parse the data and use the data (happens in completion handler) */
      self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
      
    })
    
    /* 7. Start the request */
    task.resume()
    
    return task
    
  }
  
  func taskForDELETEMethod(_ method : String, _ parameters : [String:AnyObject], completionHandlerForDELETE: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
    /* 1. Set the parameters */
    
    /* 2/3. Build the URL, Configure the request */
    let request = NSMutableURLRequest(url: createURLFromParameters(parameters, withPathExtension: method, scheme: Constants.apiScheme, host: Constants.apiHost, path: Constants.apiPath))
    request.httpMethod = "DELETE"
    var xsrfCookie: HTTPCookie? = nil
    let sharedCookieStorage = HTTPCookieStorage.shared
    for cookie in sharedCookieStorage.cookies! {
      if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
    }
    if let xsrfCookie = xsrfCookie {
      request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
    }
    
    /* 4. Make the request */
    let task = session.dataTask(with: request as URLRequest, completionHandler: {
      (data, response, error) in
      
      func sendError(_ error: String) {
        let userInfo = [NSLocalizedDescriptionKey : error]
        completionHandlerForDELETE(nil, NSError(domain: "taskForDELETEMethod", code: 1, userInfo: userInfo))
      }
      
      /* GUARD: Was there an error> */
      guard (error == nil) else {
        sendError("There was an error with your request: \(error!.localizedDescription)")
        return
      }
      
      /* GUARD: Was there any data returned? */
      guard let data = data else {
        sendError("No data was returned by the request!")
        return
      }
      
      /* GUARD: Did we get a successful 2XX response? */
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
        self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForDELETE)
        return
      }
      
      /* 5/6. Parse the data and use the data (happens in completion handler) */
      self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForDELETE)
      
    })
    
    /* 7. Start the request */
    task.resume()
    
    return task
  }
  
  // given raw JSON, return a usable Foundation object
  private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
    
    var parsedResult: AnyObject! = nil
    do {
      let range = 5..<data.count
      let newData = data.subdata(in: range) /* subset response data! */
      parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as AnyObject
      if let error = parsedResult["error"] as? String {
        let userInfo = [NSLocalizedDescriptionKey : error]
        completionHandlerForConvertData(nil, NSError(domain: "Server error", code: 1, userInfo: userInfo))
        return
      }
    } catch {
      let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
      completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
    }
    
    completionHandlerForConvertData(parsedResult, nil)
  }
  
}


