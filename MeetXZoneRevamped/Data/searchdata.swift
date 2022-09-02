//
//  Datasource.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/07/2022.
//

import Foundation
import Combine
import CoreData
import SwiftUI


class searchdata:ObservableObject {
    
    var totaldata:[searchdata_row] = []
    @Published var searchdata:[searchdata_row] = []
    
    init()
    {
        backgroundsetup()
    }
    
    func backgroundsetup()
    {
        let file_url:URL? = Bundle.main.url(forResource: "cities15000", withExtension: "txt")
        guard let file_url = file_url else {return}
        
        do {
            let contents:String = try String(contentsOf: file_url)
            let rows = contents.components(separatedBy: "\n")
            for row in rows {
                let final_transform = row.components(separatedBy: "\t")
                if (final_transform.count != 19) {continue}
                let id = final_transform[0]
                let name = final_transform[1]
                let countrycode = final_transform[8]
                let alternative_names = final_transform[3]
                let timezone = TimeZone(identifier: final_transform[17])!
                totaldata.append(.init(id: id, name: name, countrycode: countrycode, alternative_names: alternative_names, timezone: timezone, tick: false))
            }
            searchdata = totaldata
        }
        catch {fatalError()}
    }
    
    func searching(searchtext:String)
    {
        Task(priority: .userInitiated) {
            if (searchtext.isEmpty) {
                await MainActor.run { self.searchdata = totaldata}
                return
            }
            
            let local_search = totaldata.filter({ row in
                if (row.name.localizedStandardContains(searchtext)) {return true}
                if (row.countrycode.localizedStandardContains(searchtext)) {return true}
                if (row.timezone.abbreviation()!.localizedStandardContains(searchtext)) {return true}
                return false
            })
            await MainActor.run {self.searchdata = local_search}
        }
    }
    
    func fetch_current_timezone() -> [searchdata_row] {
        
        let current_tz:TimeZone = TimeZone.current
        var listofresults:[searchdata_row] = []
        
        for searchdata_row in totaldata {
            if (searchdata_row.timezone == current_tz)
            {
                let cityname:String = current_tz.identifier.components(separatedBy: "/").last!
                if (searchdata_row.name == cityname) {listofresults.append(searchdata_row)}
            }
        }
        return listofresults
    }
}

class searchdata_row:ObservableObject, Identifiable, Hashable {
    static func == (lhs: searchdata_row, rhs: searchdata_row) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    var id:String
    var name:String
    var countrycode:String
    var alternative_names:String
    var timezone:TimeZone
    @Published var tick:Bool = false
    
    init(id: String, name: String, countrycode: String, alternative_names: String, timezone: TimeZone, tick: Bool) {
        self.id = id
        self.name = name
        self.countrycode = countrycode
        self.alternative_names = alternative_names
        self.timezone = timezone
        self.tick = tick
    }
}

extension FetchedResults<SavedTimeZone> {

}
