//
//  SideBar.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 31/08/2022.
//

import SwiftUI
import CoreData

struct SideBar: View {
    
    var sectionA:FetchedResults<SavedTimeZone>
    var sectionB:FetchedResults<SavedTimeZone>
        
    @Environment(\.managedObjectContext) var moc:NSManagedObjectContext
    
    @Binding var selection:Bool?
    
    init(_ sectionA: FetchedResults<SavedTimeZone>, _ sectionB: FetchedResults<SavedTimeZone>, _ selection:Binding<Bool?>) {
        self.sectionA = sectionA
        self.sectionB = sectionB
        self._selection = selection
    }
    
    var body: some View {
        List(selection: $selection) {
            Section("Local Time Zone") {
                ForEach(sectionA) {val in
                    Text(val.nameofcity ?? "")
                }
                .onDelete(perform: {onDelete($0, true)})
            }
            
            Section("Comparison Time Zones") {
                ForEach(sectionB) {val in
                    Text(val.nameofcity ?? "")
                }
                .onMove(perform: { source, destination in
                    var temparr:[SavedTimeZone] = sectionB.sorted(by: {$0.order_no < $1.order_no})
                    temparr.move(fromOffsets: source, toOffset: destination)
                    for i in 0..<temparr.count {temparr[i].order_no = Float(i)}
                    do {try moc.save()}
                    catch {fatalError()}

                })
                .onDelete(perform: {onDelete($0, false)})
            }
        }
        .onAppear {
            pruning()
        }
        
    }
    
    func pruning()
    {
        while(sectionA.count > 1)
        {
            let object = sectionA.last!
            moc.delete(object)
        }
        do {try moc.save()}
        catch {fatalError()}

    }

}

extension SideBar {
    func onDelete(_ indexset:IndexSet, _ is_sectionA:Bool)
    {
        for val in indexset {
            if (is_sectionA)
            {
                moc.delete (sectionA[val] )
            }
            else
            {
                moc.delete(sectionB[val])
            }
            
            do {try moc.save()}
            catch {fatalError()}
        }
    }
}

