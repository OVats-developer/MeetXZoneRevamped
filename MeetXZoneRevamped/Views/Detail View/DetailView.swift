//
//  DetailView.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    @State var offset:CGFloat = 0
    var width:CGFloat = 100 * 24
    var height:CGFloat = 60
    
    @State var selected_date:Date = .init()
    
    @FetchRequest var sectionA:FetchedResults<SavedTimeZone>
    @FetchRequest var sectionB:FetchedResults<SavedTimeZone>

    init() {
        _sectionA = FetchRequest(sortDescriptors: [],
                                 predicate: NSPredicate(format: "isFirst == true"))
        _sectionB = FetchRequest(sortDescriptors: [.init(key: "order_no", ascending: true)],
                                 predicate: NSPredicate(format: "isFirst == false"))
    }
    
    var body: some View {
        if (sectionA.count == 0)
        {
            Text("Set Reference Zone")
        }
        else
        {
            VStack {
                DatePicker("Selected Date", selection: $selected_date, displayedComponents: [.date])
                mainview()
            }
        }
    }
    
    @ViewBuilder
    func mainview() -> some View
    {
        let topzone = timezoner(zone: sectionA.first!)
        let topname = sectionA.first!.nameofcity ?? ""
        
        Section(topname) {
            UI_ScrollView(offset: $offset, content: {
                SectionBRow(r_tz: topzone, height: height, date: $selected_date)
            }, height: height)
        }.frame(height:height)

        Divider()
        List(sectionB) { zone in
            let tz = timezoner(zone: zone)
            let section_name = zone.nameofcity ?? ""
            
            Section(section_name) {
                UI_ScrollView(offset: $offset, content: {
                    SectionBRow(r_tz: tz, height: height, date: $selected_date)
                }, height: height)
            }
            .listRowInsets(EdgeInsets())
            .frame(height:height)

        }.listStyle(.plain)
    }
}

extension DetailView {
    
    func timezoner(zone:SavedTimeZone) -> TimeZone
    {
        return TimeZone(identifier: zone.identifier!)!
    }
}

struct DetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ContentView()
            .environmentObject(searchdata())
            .environmentObject(PresenterManager())
            .environment(\.managedObjectContext, cd_container.context)
    }
}
