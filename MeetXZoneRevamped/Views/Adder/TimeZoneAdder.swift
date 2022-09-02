//
//  TimeZoneAdder.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 31/08/2022.
//

import SwiftUI

struct TimeZoneAdder: View {
    
    @EnvironmentObject var searcher:searchdata
    @StateObject var vm:TimeZoneAdderVM = .init()
    
    @FetchRequest var sectionA:FetchedResults<SavedTimeZone>
    @FetchRequest var sectionB:FetchedResults<SavedTimeZone>
    
    private var did_save = NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange)
    
    
    init()
    {
        _sectionA = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFirst == true"))
        _sectionB = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFirst == false"))
        
    }
    
    
    var body: some View {
        GeometryReader {reader in
            List {
                ForEach(searcher.searchdata) {val in
                    AdderRow(data: val, on_delete: {
                        
                    })
                        .onAppear {
                            vm.cache_append(val: val)
                            vm.check_val(val: val)
                        }
                        .onDisappear { vm.cache_remove(val: val) }
                }
            }
            .onAppear {
                vm.setup(sectionA, sectionB)
            }
            .onReceive(did_save) { _ in
                vm.contextChange(sectionA: sectionA, sectionB: sectionB)
            }
        }
    }
}

struct TimeZoneAdder_Previews: PreviewProvider {
    static var previews: some View {
        TimeZoneAdder().environmentObject(searchdata())
    }
}
