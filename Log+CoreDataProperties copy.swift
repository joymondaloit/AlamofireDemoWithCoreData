//
//  Log+CoreDataProperties.swift
//  
//
//  Created by Joy Mondal on 01/08/18.
//
//

import Foundation
import CoreData


extension Log {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Log> {
        return NSFetchRequest<Log>(entityName: "Log")
    }

    @NSManaged public var albumId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var thumbnailUrl: String?

}
