//
//  DataCamplitionListener.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import Foundation

import Foundation

protocol DataCompletionListener {
  func onRetriveStudentLocationSuccess()
  func onDataLoadFailure(_ errorString: NSError)
}
