//
//  MapStory.swift
//  GMapsDemo
//
//  Created by Tamara Austin on 7/17/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import GoogleMaps

class MapStory: NSObject {
    let coordinates: CLLocationCoordinate2D
    let count: Int

    init(coordinates: CLLocationCoordinate2D, count: Int) {
        self.coordinates = coordinates
        self.count = count
    }
}
