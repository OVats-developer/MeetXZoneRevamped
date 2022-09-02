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
    
    var body: some View {
        ZStack {
            if (working_hour)
            {
                Color.init(red: 0.3, green: 0.7, blue: 1, opacity: 0.75)
            }
            else
            {
                Color.gray.opacity(0.4)
            }
            HStack {
                Divider()
                Spacer()
                Text(label)
                    .fontWeight(.bold)
                Spacer()
                Divider()
            }
            .contentShape(Rectangle())
        }
        .cornerRadius(3)
        .padding(.horizontal, 1)
        .frame(width: 100, height:40)
    }
}

struct DetailRowCell_Previews: PreviewProvider {
    static var previews: some View {
        SectionBCell(working_hour: true,
                  label: "11:00")
    }
}
