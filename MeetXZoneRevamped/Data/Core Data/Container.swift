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
    
    var container:NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "TimeZoneV3")
        container.loadPersistentStores { descrption, err in
            if (err != nil) {fatalError()}
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return container
    }()
    
    /*
    var frcA:NSFetchedResultsController<SavedTimeZone>!
    var frcB:NSFetchedResultsController<SavedTimeZone>!

    override init()
    {
        super.init()
        let frc_requestA:NSFetchRequest<SavedTimeZone> = SavedTimeZone.fetchRequest()
        frc_requestA.sortDescriptors = []
        frc_requestA.predicate = NSPredicate(format: "isFirst == true")
        frcA = .init(fetchRequest: frc_requestA, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        let frc_requestB:NSFetchRequest<SavedTimeZone> = SavedTimeZone.fetchRequest()
        frc_requestB.sortDescriptors = []
        frc_requestB.predicate = NSPredicate(format: "isFirst == false")
        frcB = .init(fetchRequest: frc_requestB, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try frcA.performFetch()
            try frcB.performFetch()
        }
        catch {
            fatalError()
        }
        
    }
    */
    func save()
    {
        do {
            try container.viewContext.save()
        }
        catch {fatalError()}
        
    }
    
    
    var context:NSManagedObjectContext {
        return container.viewContext
    }
}

