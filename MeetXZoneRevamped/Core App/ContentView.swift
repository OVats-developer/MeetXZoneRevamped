//
//  ContentView.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest var sectionA:FetchedResults<SavedTimeZone>
    @FetchRequest var sectionB:FetchedResults<SavedTimeZone>
    
    @EnvironmentObject var presenter:PresenterManager
        
    init()
    {
        _sectionA = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFirst == true"))
        _sectionB = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFirst == false"))
    }

    
    
    var body: some View {
        if #available(iOS 16, macOS 16, *) {
            NavigationSplitView(sidebar: {
                SideBarWrapper()
            }, detail: {
                DetailView()
            })
            .navigationSplitViewStyle(.balanced)
            .sheet(isPresented: $presenter.show_adder) {
                TimeZoneAdder()
            }
        }
        else {
            NavigationView {
                SideBarWrapper()
            }
            .sheet(isPresented: $presenter.show_adder) {
                TimeZoneAdder()
            }
        }
    
    }
}
    
    enum navigation:Hashable {
        case adder
        case mainview
    }
    
