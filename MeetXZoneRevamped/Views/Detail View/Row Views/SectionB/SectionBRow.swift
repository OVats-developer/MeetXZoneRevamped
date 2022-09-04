//
//  SectionBRow.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import SwiftUI

struct SectionBRow: View {
    
    var height:CGFloat
    
    var calendar:Calendar = .current
    var b_tz:TimeZone = .current
    var r_tz:TimeZone
    
    @Binding var selected_date:Date
    
    var df:DateFormatter
    
    
    init(r_tz:TimeZone, height: CGFloat, date:Binding<Date>) {
        self.r_tz = r_tz
        self.height = height
        self._selected_date = date
        
        df = .init()
        df.timeZone = r_tz
        df.dateFormat = "HH:mm"
        
    }
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<24) {val in
                let converted_date = calendar.dateBySetting(timeZone: r_tz, of: selected_date, hour: val)
                let label = df.string(from: converted_date)
                SectionBCell(color_width: 1, left_sided: true, label: label, height: height)
            }
        }
    }
}

