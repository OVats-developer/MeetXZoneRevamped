//
//  DateExtension.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import Foundation


extension Calendar {
    
    func dateBySetting(timeZone: TimeZone, of date: Date, hour:Int) -> Date {
        var base_components = Calendar.current.dateComponents(in: self.timeZone, from: date)
        base_components.hour = hour
        base_components.minute = 0
        base_components.second = 1
        let base_date = base_components.date!
        return Calendar.current.dateComponents(in: timeZone, from: base_date).date!
    }
    
    
    func tz_hour(timeZone: TimeZone, of date: Date, hour:Int) -> Int {
        var base_components = Calendar.current.dateComponents(in: self.timeZone, from: date)
        base_components.hour = hour
        base_components.minute = 0
        base_components.second = 1
        let base_date = base_components.date!
        return Calendar.current.dateComponents(in: timeZone, from: base_date).hour ?? 0
    }

    
    
    func tz_conversion(timeZone: TimeZone, of date: Date) -> Date {
        return Calendar.current.dateComponents(in: timeZone, from: date).date!
    }
}

extension Date {
    func start_day(b_tz:TimeZone) -> Date
    {
        var comps = Calendar.current.dateComponents(in: b_tz, from: self)
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        return comps.date!
    }
    
    func end_day(b_tz:TimeZone) -> Date
    {
        var comps = Calendar.current.dateComponents(in: b_tz, from: self)
        comps.hour = 23
        comps.minute = 59
        comps.second = 59
        return comps.date!
    }
}
