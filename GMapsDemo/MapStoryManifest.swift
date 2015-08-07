//
//  MapStoryManifest.swift
//  GMapsDemo
//
//  Created by Tamara Austin on 7/24/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class MapStoryManifest: NSObject {
    let bottomTierUpvoteMax: Int
    let topTierUpvoteMin: Int
    let averageUpvoteCount: Int
    let mapStories: [MapStory]
    
    init(mapStories: [MapStory]){
        self.mapStories = mapStories
        var highCount = 0
        var totalCount = 0
        for story in mapStories {
            if story.count > highCount {
                highCount = story.count
            }
            totalCount += story.count
        }
        bottomTierUpvoteMax = Int(0.25 * Double(highCount))
        topTierUpvoteMin = Int(0.75 * Double(highCount))
        averageUpvoteCount = Int(totalCount / mapStories.count)
    }
    
   
}
