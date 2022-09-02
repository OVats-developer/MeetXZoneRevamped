//
//  TimeZoneAdderVM.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import Foundation
import SwiftUI


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
        for refA in sectionA {
            if (val.name == refA.nameofcity ?? "") {val.tick = true; return;}
        }
        
        for refB in sectionB {
            if (val.name == refB.nameofcity ?? "") {val.tick = true; return;}
        }
    }
    
    
    func check_cache()
    {
        if (self.initialized == false) {return}
        for val in cache {
            for refA in sectionA {
                if (val.name == refA.nameofcity ?? "") {val.tick = true; break;}
            }
            
            for refB in sectionB {
                if (val.name == refB.nameofcity ?? "") {val.tick = true; break;}
            }
        }
    }
}
