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
    var height:CGFloat = 100
    
    var body: some View {
        List
        {
            Section("Testing") {
                UI_ScrollView(offset: $offset, content: {
                    SectionBRow(r_tz: .init(abbreviation: "GMT+1")!)
                }, width: width, height: height)
                .listRowBackground(EmptyView())
                .listRowInsets(EdgeInsets())
            }
            
            UI_ScrollView(offset: $offset, content: {
                SectionBRow(r_tz: .init(abbreviation: "GMT+10")!)
            }, width: width, height: height)
            .listRowBackground(EmptyView())
            .listRowInsets(EdgeInsets())

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
