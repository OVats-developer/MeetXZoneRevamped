//
//  DateExtension.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import Foundation


extension Calendar {
    
    func dateBySetting(timeZone: TimeZone, of date: Date, hour:Int) -> Date {
        
        var local_date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: date)!
        var local_components = Calendar.current.dateComponents(in: self.timeZone, from: local_date)
        return self.date(from: local_components)!
    }
}
