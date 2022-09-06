//
//  SIdeBarWrapper.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import SwiftUI

struct SideBarWrapper: View {
    
    
    @FetchRequest var sectionA:FetchedResults<SavedTimeZone>
    @FetchRequest var sectionB:FetchedResults<SavedTimeZone>
    
    @EnvironmentObject var presenter:PresenterManager
    
    @State var testing:Bool? = false
    
    init()
    {
        _sectionA = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFirst == true"))
        _sectionB = FetchRequest(sortDescriptors: [.init(key: "order_no", ascending: true)], predicate: NSPredicate(format: "isFirst == false"))
    }
    
    
    var body: some View {
        ZStack {
            SideBar(sectionA, sectionB, $testing)
                .navigationTitle("Meet - X - Zone")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            DispatchQueue.main.async {
                                presenter.show_adder = true
                            }
                        } label: {
                            Image(systemName: "plus").resizable()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presenter.show_wh = true
                        } label: {
                            Image(systemName: "clock.circle").resizable()
                        }
                    }
                }
            
#if os(iOS)
            if (UIDevice.current.userInterfaceIdiom == .phone)
            {
                GeometryReader {reader in
                    let width = reader.size.width
                    VStack(spacing:0) {
                        Spacer()
                        SideBarNavButton(width: width,
                                         show: ((sectionA.count >= 1) &&  (sectionB.count >= 1)))
                        .onTapGesture {
                            testing = true
                        }
                    }.padding()
                }
            }
#endif
        }
    }
}

