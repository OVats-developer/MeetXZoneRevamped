//
//  SavedTimeZone+CoreDataProperties.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 04/07/2022.
//
//

import Foundation
import CoreData
import UniformTypeIdentifiers


extension SavedTimeZone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedTimeZone> {
        return NSFetchRequest<SavedTimeZone>(entityName: "SavedTimeZone")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var isFirst: Bool
    @NSManaged public var nameofcity: String?
    @NSManaged public var timezone: String?

}

extension SavedTimeZone : Identifiable {

}

