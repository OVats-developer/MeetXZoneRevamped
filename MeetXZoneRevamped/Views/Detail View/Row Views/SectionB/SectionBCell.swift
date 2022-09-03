//
//  DetailRow.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import SwiftUI

struct SectionBCell: View {
    
    var working_hour:Bool
    var label:String
    
    var height:CGFloat
    
    var body: some View {
        ZStack {
            if (working_hour)
            {
                Color.init(red: 0.3, green: 0.7, blue: 1, opacity: 0.75)
            }
            
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

struct DetailRowCell_Previews: PreviewProvider {
    static var previews: some View {
        SectionBCell(working_hour: false,
                     label: "11:00", height: 60)
    }
}
