//
//  DetailRow.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import SwiftUI

struct SectionBCell: View {

    @EnvironmentObject var prefman:PreferenceManager
    
    var color_width:CGFloat
    
    var left_sided:Bool
    
    var label:String
    
    var height:CGFloat
    
    var body: some View {
        ZStack {
            HStack (spacing:0) {
                if (!left_sided) {Spacer()}
                prefman.sc.frame(width: 100 * color_width)
                if (left_sided) {Spacer()}
            }.frame(width: 100, height: height)
            
            HStack(spacing:0)
            {
                Spacer()
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 2, height: 15)
                    Spacer()
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 3, height: 20)
                    Spacer()
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 2, height: 15)
                    Spacer()
                }

                Spacer()
            }.frame(width: 100, height: height)
            
            HStack(spacing:0) {
                Rectangle()
                    .frame(width: 2, height: height)
                Text(label)
                    .fontWeight(.black)
                    .frame(width: 96, height: height)
                Rectangle()
                    .frame(width: 2, height: height)
                Divider()
            }

        }
        .contentShape(Rectangle())
        .frame(width: 100, height:height)
    }
}
