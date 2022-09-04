//
//  SavedTimeZone+CoreDataProperties.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 03/09/2022.
//
//

import Foundation
import CoreData


extension SavedTimeZone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedTimeZone> {
        return NSFetchRequest<SavedTimeZone>(entityName: "SavedTimeZone")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var isFirst: Bool
    @NSManaged public var nameofcity: String?
    @NSManaged public var timezone: String?
    @NSManaged public var order_no: Float

}

extension SavedTimeZone : Identifiable {

}
