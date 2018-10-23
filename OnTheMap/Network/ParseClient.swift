//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 19/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

class ParseClient : BaseClient {
  let session = URLSession.shared
  
  // MARK: Singleton
  
  static let sharedInstance = ParseClient()
  
  // MARK: Initializers
  
  override init() {
    super.init()
  }
  
  func taskForGETMethod(_ method : String, _ parameters : [String:AnyObject], completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
    
    /* 1. Set the parameters */
    
    /* 2/3. Build the URL, Configure the request */
    let request = NSMutableURLRequest(url: createURLFromParameters(parameters, withPathExtension: method, scheme: Constants.apiScheme, host: Constants.apiHost, path: Constants.apiPath))
    request.httpMethod = "GET"
    request.addValue(HeaderValues.applicationId, forHTTPHeaderField: HeaderKeys.applicationId)
    request.addValue(HeaderValues.restApi, forHTTPHeaderField: HeaderKeys.restApi)
    
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
  
  func taskForPOSTPUTMethod(_ httpMethod: String, _ method: String, _ body: Data?, _ parameters: [String:AnyObject], completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
    
    /* 1. Set the parameters */
    
    /* 2/3. Build the URL, Configure the request */
    let request = NSMutableURLRequest(url: createURLFromParameters(parameters, withPathExtension: method, scheme: Constants.apiScheme, host: Constants.apiHost, path: Constants.apiPath))
    request.httpMethod = httpMethod
    request.addValue(HeaderValues.applicationId, forHTTPHeaderField: HeaderKeys.applicationId)
    request.addValue(HeaderValues.restApi, forHTTPHeaderField: HeaderKeys.restApi)
    request.addValue(HeaderValues.contentType, forHTTPHeaderField: HeaderKeys.contentType)
    request.httpBody = body
    
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
  
  // given raw JSON, return a usable Foundation object
  private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
    
    var parsedResult: AnyObject! = nil
    do {
      parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
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

