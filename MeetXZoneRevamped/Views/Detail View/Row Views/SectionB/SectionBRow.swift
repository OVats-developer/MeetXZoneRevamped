//
//  SectionBRow.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import SwiftUI

struct SectionBRow: View {
    
    var height:CGFloat
    
    @EnvironmentObject var prefman:PreferenceManager
    
    var calendar:Calendar = .current
    var b_tz:TimeZone
    var r_tz:TimeZone
    
    @Binding var selected_date:Date
    
    var df:DateFormatter
    
    
    init(b_tz:TimeZone ,r_tz:TimeZone, height: CGFloat, date:Binding<Date>) {
        self.r_tz = r_tz
        self.height = height
        self._selected_date = date
        self.b_tz = b_tz
        calendar.timeZone = b_tz
        
        df = .init()
        df.timeZone = r_tz
        df.dateFormat = "HH:mm"
        
    }
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<24) {val in
                let converted_date = calendar.dateBySetting(timeZone: r_tz, of: selected_date, hour: val)
                let label = df.string(from: converted_date)
                let result = handle_calculation(val: val)
                SectionBCell(color_width: result.0, left_sided: result.1, label: label, height: height)
            }
        }
    }
    
    
    func handle_calculation(val:Int) -> (CGFloat, Bool)
    {
        if (val < prefman.sh)
        {
            return (0,false)
        }
        else if (val > prefman.eh)
        {
            return (0,false)
        }
        
        if (prefman.sh == prefman.eh)
        {
            if (val != prefman.sh) {return (0,false)}
            if (prefman.sm < prefman.em)
            {
                return (0.5, true)
            }
            else if (prefman.sm == prefman.em)
            {
                return (0, true)
            }
            else
            {
                return (0.5, false)
            }
        }
        
        if (val == prefman.eh)
        {
            return (CGFloat(prefman.em)/60, true)
        }
        else if (val == prefman.sh)
        {
            return (CGFloat(60 - prefman.sm)/60, false)
        }
        
        return (1, false)

    }

}

