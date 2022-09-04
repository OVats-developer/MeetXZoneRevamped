//
//  SectionBRow.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import SwiftUI

struct SampleRow: View {
    
    var height:CGFloat
    
    var b_tz:TimeZone = .current
    
    var start_hour:Int
    var end_hour:Int
    
    var color:Color
        
    
    var start_minute:Int
    var end_minute:Int

    var selected_date:Date = .init()
    
    var df:DateFormatter
    var calendar:Calendar = .current
    
    init(height: CGFloat, sh:Int, eh:Int, sm:Int, em:Int, sc:Color) {
        
        self.height = height
        self.start_hour = sh
        self.end_hour = eh
        
        self.start_minute = sm
        self.end_minute = em

        self.color = sc
        
        df = .init()
        df.timeZone = b_tz
        df.dateFormat = "HH:mm"
        
    }
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<24) {val in
                
                let result = handle_calculation(val: val)
                
                let converted_date = calendar.dateBySetting(timeZone: b_tz, of: selected_date, hour: val)
                let label = df.string(from: converted_date)
                SampleCell(color_width: result.0, color: color, left_sided: result.1, label: label, height: 60)
            }
        }
    }
    
    func handle_calculation(val:Int) -> (CGFloat, Bool)
    {
        if (val < start_hour)
        {
            return (0,false)
        }
        else if (val > end_hour)
        {
            return (0,false)
        }
        
        if (start_hour == end_hour)
        {
            if (val != start_hour) {return (0,false)}
            if (start_minute < end_minute)
            {
                return (0.5, true)
            }
            else if (start_minute == end_minute)
            {
                return (0, true)
            }
            else
            {
                return (0.5, false)
            }
        }
        
        if (val == end_hour)
        {
            return (CGFloat(end_minute)/60, true)
        }
        else if (val == start_hour)
        {
            return (CGFloat(60 - start_minute)/60, false)
        }
        
        return (1, false)

    }
}
