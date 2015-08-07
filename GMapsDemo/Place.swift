//
//  Place.swift
//  
//
//  Created by Tamara Austin on 7/21/15.
//
//

import Foundation
import CoreData

class Place: NSManagedObject {

    @NSManaged var googlePlaceId: String
    @NSManaged var longitude: NSDecimalNumber
    @NSManaged var latitude: NSDecimalNumber
    @NSManaged var upvotes: [Upvote]

}
