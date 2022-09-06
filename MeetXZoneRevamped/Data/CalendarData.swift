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
    
    override init()
    {
        super.init()
        calendarstore.requestAccess(to: .event) { granted, err in
            self.access_granted = granted
            self.get_events(b_tz: .current, date: .init())
        }
    }
    
    func get_calendar_ids() -> [String]?
    {
        return UserDefaults.standard.array(forKey: "calendarIDs") as? [String]
    }
    
    func get_events(b_tz:TimeZone ,date:Date)
    {
        let start = date.start_day(b_tz: b_tz)
        let end = date.end_day(b_tz: b_tz)
        
        let predicate = calendarstore.predicateForEvents(withStart: start, end: end, calendars: calendars)
        let events = calendarstore.events(matching: predicate)
        let sorted = events.sorted { $0.startDate < $1.startDate }
        
        var levels:Int = 0
        var buckets:[Int] = Array(repeating: 0, count: 24)
        
        var calendar = Calendar.current
        
        for event in events {
            calendar.timeZone = event.timeZone!
            
            var start_date_components = calendar.dateComponents(in: b_tz, from: event.startDate!)
            
            var end_date = calendar.date(byAdding: .minute, value: -1, to: event.endDate)
            var end_date_components = calendar.dateComponents(in: b_tz, from: end_date!)
            
            if (end_date_components.day! > start_date_components.day!)
            {
                for val in start_date_components.hour!..<24 { buckets[val] += 1 }
            }
            
            else
            {
                for val in start_date_components.hour!...end_date_components.hour! {
                    buckets[val] += 1
                }
            }
        }
        
        print(buckets)
        print(buckets.max()!)
    }
}
