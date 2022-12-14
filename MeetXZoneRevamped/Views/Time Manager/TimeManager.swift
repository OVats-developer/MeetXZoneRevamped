//
//  TimeManager.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 04/09/2022.
//

import SwiftUI

struct TimeManager: View {
    
    @State var sh:Int = 8
    @State var eh:Int = 17
    @State var sm:Int = 0
    @State var em:Int = 0

    @State var sc:Color = Color.init(red: 0.3, green: 0.7, blue: 1, opacity: 0.75)
    
    @EnvironmentObject var pref_man:PreferenceManager
    @EnvironmentObject var pres_man:PresenterManager

    var body: some View {
        if #available(iOS 16, macOS 13, *)
        {
            NavigationStack {
                mainview()
            }
        }
        else
        {
            NavigationView {
                mainview()
            }.navigationViewStyle(.stack)
        }
    }
    
    @ViewBuilder
    func mainview() -> some View
    {
        VStack(spacing:0)
        {
            List {
                Section("Color Picker") {
                    ColorPicker("Choose Color", selection: $sc)
                }
                
                Section("Start of Working Hours") {
                    CustomPicker(hour: $sh, minute: $sm)
                        .padding([.horizontal, .bottom])
                        .frame(height:100)
                }
                
                Section("End of Working Hours") {
                    CustomPicker(hour: $eh, minute: $eh)
                        .padding(.bottom)
                        .frame(height:100)
                }
                
                Section("Sample") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        SampleRow(height: 60, sh: sh, eh: eh, sm: sm, em: em, sc: sc)
                    }
                }
                
            }.listStyle(.plain)
        }
        .navigationTitle("Working Hours")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button("Save") {
                    pref_man.save(sh: sh, sm: sm, eh: eh, em: em, sc: sc)
                    pres_man.show_wh = false
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading)
            {
                Button("Dismiss") {
                    DispatchQueue.main.async {
                        pres_man.show_wh = false
                    }
                }
            }
        }
        .onAppear {
            sh = pref_man.sh
            eh = pref_man.eh
            sm = pref_man.sm
            em = pref_man.em
            
            sc = pref_man.sc
        }
    }
}

struct TimeManager_Previews: PreviewProvider {
    static var previews: some View {
        TimeManager()
            .environmentObject(PreferenceManager())
            .environmentObject(PresenterManager())
    }
}
