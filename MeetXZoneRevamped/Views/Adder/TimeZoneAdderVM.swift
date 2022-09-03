//
//  TimeZoneAdderVM.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import Foundation
import SwiftUI
import CoreData


class TimeZoneAdderVM:ObservableObject {
    
    var cache:[searchdata_row] = []
        
    var sectionA:FetchedResults<SavedTimeZone>!
    var sectionB:FetchedResults<SavedTimeZone>!
    
    var initialized:Bool = false

    
    func cache_append(val:searchdata_row)
    {
        cache.append(val)
    }
    
    func cache_remove(val:searchdata_row)
    {
        cache.removeAll { rm in
            rm.name == val.name
        }
    }

    
    func setup(_ sectionA:FetchedResults<SavedTimeZone>,
                       _ sectionB:FetchedResults<SavedTimeZone>)
    {
        self.initialized = true
        self.sectionA = sectionA
        self.sectionB = sectionB
    }

    func contextChange(sectionA:FetchedResults<SavedTimeZone>,
                       sectionB:FetchedResults<SavedTimeZone>)
    {
        if (self.initialized == false) {return}
        self.sectionA = sectionA
        self.sectionB = sectionB
        check_cache()
    }
    
    func check_val(val:searchdata_row)
    {
        if (self.initialized == false) {return}
        looping_val(val: val)
    }
    
    func check_cache()
    {
        if (self.initialized == false) {return}
        for val in cache {
            looping_val(val: val)
        }
    }
    
    func looping_val(val:searchdata_row)
    {
        for refA in sectionA {
            if (val.name == refA.nameofcity ?? "") {
                withAnimation { val.tick = true;}
                return;
            }
        }
        
        for refB in sectionB {
            if (val.name == refB.nameofcity ?? "") {
                withAnimation { val.tick = true;}
                return;
            }
        }
        
        withAnimation { val.tick = false;}
    }
    
    func onDelete(val:searchdata_row, moc:NSManagedObjectContext)
    {
        for refA in sectionA {
            if (val.name == refA.nameofcity ?? "") {
                moc.delete(refA)
                save(moc)
                return
            }
        }
        
        for refB in sectionB {
            if (val.name == refB.nameofcity ?? "") {
                moc.delete(refB)
                save(moc)
                return
            }
        }
    }
    
    
    func update_sectionA(val:searchdata_row, moc:NSManagedObjectContext)
    {
        for val in sectionA {
            moc.delete(val)
        }
        
        for cd_val in sectionB {
            if (val.name == cd_val.nameofcity) {cd_val.isFirst = true; save(moc); return;}
        }
        
        let reference = SavedTimeZone(context: moc)
        reference.nameofcity = val.name
        reference.isFirst = true
        reference.timezone = val.timezone.abbreviation()
        reference.identifier = val.timezone.identifier
        
        save(moc)
    }
    
    func save(_ moc:NSManagedObjectContext)
    {
        do {try moc.save()} catch {fatalError()}
    }
}
