//
//  CalendarData.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 10/07/2022.
//

import Foundation
import Combine
import EventKit

class calendardata:NSObject, ObservableObject {
    
    var calendarstore:EKEventStore = .init()
    var calendars:[EKCalendar] = []
    
    var access_granted:Bool = false
    
    var hour_width:CGFloat = 100
    var hour_height:CGFloat = 60
    
    @Published var num_levels:Int = 1
    @Published var calendar_events:[[calendar_rectangle]] = []
    
    override init()
    {
        super.init()
        calendarstore.requestAccess(to: .event) { granted, err in
            self.access_granted = granted
            Task {
                await MainActor.run {
                    let events = self.get_events(date: .init())
                    self.calendar_events = self.handle_frames(btz: .current, events: events, date: .init())
                }
            }
        }
    }
    
    func get_calendar_ids() -> [String]?
    {
        return UserDefaults.standard.array(forKey: "calendarIDs") as? [String]
    }
    
    func get_events(date:Date) -> [EKEvent]
    {
        let ids = get_calendar_ids()
        var calendars:[EKCalendar]?
        
        if (ids != nil)
        {
            calendars = []
            for id in ids! {
                let cal = calendarstore.calendar(withIdentifier: id)
                if (cal != nil) {calendars?.append(cal!)}
            }
            if (calendars?.count == 0) {calendars = nil}
        }
        
        let start_date = handle_start_date(date: date)
        let end_date = handle_end_date(date: date)
        
        let pred = calendarstore.predicateForEvents(withStart: start_date, end: end_date, calendars: calendars)
        return calendarstore.events(matching: pred)
    }
    
    func handle_frames(btz:TimeZone, events:[EKEvent], date:Date) -> [[calendar_rectangle]]
    {
        var levels:[[calendar_rectangle]] = []
        var calendar = Calendar.current
        
        
        for event in events {
            
            calendar.timeZone = event.timeZone ?? .current
            let ek_sd = calendar.tz_conversion(timeZone: btz, of: event.startDate)
            let ek_ed = calendar.tz_conversion(timeZone: btz, of: event.endDate)

            if (ek_sd < handle_start_date(date: date)) {continue}
            let start_components = calendar.dateComponents(in: btz, from: ek_sd)
            let end_components = calendar.dateComponents(in: btz, from: ek_ed)

            let title = event.title ?? ""
            let sdfz = (start_components.hour ?? 0) * 60 + (start_components.minute ?? 0)
            let edfz = (end_components.hour ?? 0) * 60 + (end_components.minute ?? 0)
            let num_hours = CGFloat(edfz - sdfz)/60.0
            let hours = CGFloat(sdfz)/60.0
            
            if (levels.count == 0) {
                levels.append([.init(name: title, num_hours: num_hours, level: 0, hour: hours, sdfz: sdfz, edfz: edfz)])
                continue
            }
            
            var placed:Bool = false
            

            for i in 0..<levels.count {
                
                var overlap:Bool = false
                
                
                for ek in levels[i] {
                    if ( (ek.sdfz <= edfz ) && ek.sdfz >= sdfz) {overlap = true; break}
                    if ( (ek.edfz >= sdfz ) && ek.edfz <= ek.edfz) {overlap = true; break}
                    
                    levels[i].append(.init(name: title, num_hours: num_hours, level: i, hour: hours, sdfz: sdfz, edfz: edfz))
                    placed = true
                    break
                }
                
                if (overlap) {continue}
                
                if (placed) {break}
            }
            
            if (!placed) {
                levels.append([.init(name: title, num_hours: num_hours, level: levels.count, hour: hours, sdfz: sdfz, edfz: edfz)])
            }

        }
        
        for level in levels {
            print("New Level")
            for ek in level {
                print(ek.name, separator: " ")
            }
        }
        
        return levels
    }
    
    
    func handle_start_date(date:Date) -> Date
    {
        var cal:Calendar = .current
        var current_components = cal.dateComponents(in: .current, from: date)
        current_components.hour = 0
        current_components.minute = 0
        current_components.second = 0
        current_components.nanosecond = 0
        return current_components.date!
    }
    
    func handle_end_date(date:Date) -> Date
    {
        var cal:Calendar = .current
        var current_components = cal.dateComponents(in: .current, from: date)
        current_components.hour = 23
        current_components.minute = 59
        current_components.second = 59
        return current_components.date!
    }

}

class calendar_rectangle {
    
    var name:String
    var num_hours:CGFloat
    var level:Int
    var hour:CGFloat
    
    var sdfz:Int
    var edfz:Int

    init(name: String, num_hours: CGFloat, level: Int, hour: CGFloat, sdfz: Int, edfz: Int) {
        self.name = name
        self.num_hours = num_hours
        self.level = level
        self.hour = hour
        self.sdfz = sdfz
        self.edfz = edfz
    }
}
