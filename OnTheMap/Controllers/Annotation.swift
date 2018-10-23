//
//  File.swift
//  OnTheMap
//
//  Created by Marisha Deroubaix on 20/10/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import MapKit

class Annotation : NSObject, MKAnnotation {
  let title: String?
  let url: String
  let coordinate: CLLocationCoordinate2D
  
  init(title: String, url: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.url = url
    self.coordinate = coordinate
    
    super.init()
  }
  
  init(title: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.coordinate = coordinate
    self.url = ""
    super.init()
  }
  
  var subtitle: String? {
    return url
  }
}
