//
//  AdderRow.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 01/09/2022.
//

import SwiftUI
import CoreData

struct AdderRow: View {
    
    @ObservedObject var data:searchdata_row
    @Environment(\.managedObjectContext) var moc:NSManagedObjectContext
    
    var on_delete:() -> ()
    var make_reference: () -> ()
    
    var body: some View {
        HStack(spacing:0) {
            if (data.tick)
            {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 30, height: 30)
                    .padding(.trailing)
            }
            
            Text(data.name)
            Spacer()
            Text(data.countrycode)
        }
        .contentShape(Rectangle())
        .padding(.horizontal)
        .onTapGesture {
            if (data.tick == false) { add_timezone() }
            else { withAnimation { on_delete() } }
        }
        .contextMenu {
            VStack(spacing:0)
            {
                if (data.tick) { Button { withAnimation {  on_delete() } } label: {Text("Delete Time Zone")} }
                else { Button { add_timezone() } label: { Text("Add Time Zone")} }
                
                Button(action: {make_reference()}, label: {Text("Make Reference Time Zone")})
            }
        }
    }
    
    func add_timezone()
    {
        withAnimation {
            let new_timezone = SavedTimeZone(context: moc)
            new_timezone.nameofcity = data.name
            new_timezone.timezone = data.timezone.abbreviation()
            new_timezone.identifier = data.timezone.identifier
            new_timezone.isFirst = false
            do {try moc.save()} catch {fatalError()}
        }
        
    }
}

