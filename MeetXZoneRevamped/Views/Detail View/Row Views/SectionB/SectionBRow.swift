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
    
    var selected_date:Date = .init()
    
    var df:DateFormatter
    
    var values:[String]
    
    init(r_tz:TimeZone, height: CGFloat) {
        self.r_tz = r_tz
        self.height = height
        
        df = .init()
        df.timeZone = r_tz
        df.dateFormat = "HH:mm"
        
        var local_array:[String] = []
        
        for i in 0..<24 {
            let converted_date = calendar.dateBySetting(timeZone: r_tz, of: selected_date, hour: i)
            local_array.append(df.string(from: converted_date))
        }
        self.values = local_array
    }
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<24) {val in
                SectionBCell(working_hour: false,
                             label: values[val], height: height)
            }
        }
    }
}

struct SectionBRowPreview:PreviewProvider {
    
    static var previews: some View {
        testing()
    }
}

struct testing:View {
    
    @State var offset:CGFloat = 0
    
    var body: some View {
        VStack(spacing:0) {
            
            UI_ScrollView(offset: $offset, content: {
                SectionBRow(r_tz: .init(abbreviation: "GMT+1")!, height: 50)
            }, height: 60)
            
            UI_ScrollView(offset: $offset, content: {
                SectionBRow(r_tz: .init(abbreviation: "GMT+1")!, height: 50)
            }, height: 60)        }
    }
}
