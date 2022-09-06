//
//  MeetXZoneRevampedApp.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 27/06/2022.
//

import SwiftUI

@main
struct MeetXZoneRevampedApp: App {
    
    @StateObject var searcher:searchdata = .init()
    @StateObject var calendar:calendardata = .init()
    @StateObject var presenter:PresenterManager = .init()
    @StateObject var preferences:PreferenceManager = .init()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(searcher)
                .environmentObject(presenter)
                .environmentObject(preferences)
                .environment(\.managedObjectContext, cd_container.context)
        }
    }
}
