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
    
    override init()
    {
        super.init()
        calendarstore.requestAccess(to: .event) { granted, err in
        }
    }
}
