//
//  Container.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 04/07/2022.
//

import Foundation
import CoreData
import Combine

class cd_container:NSObject, ObservableObject {
    
    static var container:NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "TimeZoneV3")
        container.loadPersistentStores { descrption, err in
            if (err != nil) {fatalError()}
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return container
    }()
        
    
    static var context:NSManagedObjectContext {
        return container.viewContext
    }
}

