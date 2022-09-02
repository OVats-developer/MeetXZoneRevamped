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
        .padding(.horizontal)
        .onTapGesture {
            if (data.tick == false)
            {
                let new_timezone = SavedTimeZone(context: moc)
                new_timezone.nameofcity = data.name
                new_timezone.timezone = data.timezone.abbreviation()
                new_timezone.identifier = data.timezone.identifier
                new_timezone.isFirst = false
                do {try moc.save()} catch {fatalError()}
            }
        }
    }
}

