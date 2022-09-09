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
    
    @EnvironmentObject var prefman:PreferenceManager
    @EnvironmentObject var cdm:calendardata

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
                DatePicker("Selected Date", selection: $selected_date, displayedComponents: [.date]).padding(.bottom)
                mainview()
            }
        }
    }
    
    @ViewBuilder
    func mainview() -> some View
    {
        let topzone = timezoner(zone: sectionA.first!)
        let topname = sectionA.first!.nameofcity ?? ""
        
        VStack(spacing:0) {
            HStack {
                Text("Reference Time Zone - \(topname)").font(.headline).padding(.bottom).frame(height:20)
                Spacer()
            }
            UI_ScrollView(offset: $offset, content: {
                SectionBRow(b_tz: topzone, r_tz: topzone, height: height, date: $selected_date).environmentObject(prefman)
            }, height: height)
        }
        .padding(.vertical, 5)
        .frame(height:height + 35)
        .onChange(of: selected_date) { newValue in
            let events = cdm.get_events(date: newValue)
            cdm.calendar_events = cdm.handle_frames(btz: topzone, events: events, date: selected_date)
        }

        CalendarView(offset: $offset).frame(height: CGFloat(cdm.calendar_events.count) * 60)
        
        List(sectionB) { zone in
            let tz = timezoner(zone: zone)
            let section_name = zone.nameofcity ?? ""
            
            Section(section_name) {
                UI_ScrollView(offset: $offset, content: {
                    SectionBRow(b_tz: topzone, r_tz: tz, height: height, date: $selected_date).environmentObject(prefman)
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
            .environmentObject(calendardata())
            .environment(\.managedObjectContext, cd_container.context)
    }
}
