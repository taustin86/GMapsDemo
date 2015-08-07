//
//  MapStoryService.swift
//  GMapsDemo
//
//  Created by Tamara Austin on 7/17/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

class MapStoryService: NSObject {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
   
    func getMapStories() -> MapStoryManifest {
        var stories = [MapStory]()
        
        let fetchRequest = NSFetchRequest(entityName: "Place")
        if let fetchResults = context.executeFetchRequest(fetchRequest, error: nil) as? [Place] {
            for place in fetchResults {
                println("Fetch result found")
                stories.append(MapStory(coordinates: CLLocationCoordinate2DMake(place.latitude as Double, place.longitude as Double), count: place.upvotes.count))
            }
        }

        return MapStoryManifest(mapStories: stories)
    }
}
