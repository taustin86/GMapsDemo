//
//  DataHelper.swift
//  GMapsDemo
//
//  Created by Tamara Austin on 7/24/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import CoreData

class DataHelper: NSObject {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
   
    func seedDataStore(){
        let places = [
            (latitude: 38.886, longitude: -76.996),
            (latitude: 38.889, longitude: -76.989),
            (latitude: 38.888, longitude: -76.978),
            (latitude: 38.883, longitude: -76.995),
            (latitude: 38.891, longitude: -77.006)
        ]
        
        for place in places {
            let newPlace = NSEntityDescription.insertNewObjectForEntityForName("Place", inManagedObjectContext: context) as! Place
            newPlace.latitude = NSDecimalNumber(double: place.latitude)
            newPlace.longitude = NSDecimalNumber(double: place.longitude)
            
            for count in 1...Int(arc4random_uniform(29) + 1){
                let upvote = NSEntityDescription.insertNewObjectForEntityForName("Upvote", inManagedObjectContext: context) as! Upvote
                upvote.place = newPlace
                upvote.datetime = NSDate()
            }
        }
        
        context.save(nil)
    }
}
