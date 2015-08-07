//
//  Upvote.swift
//  GMapsDemo
//
//  Created by Tamara Austin on 7/24/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import Foundation
import CoreData

class Upvote: NSManagedObject {

    @NSManaged var datetime: NSDate
    @NSManaged var place: Place

}
