//
//  CalendarView.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 09/09/2022.
//

import SwiftUI
import UIKit

struct CalendarView: UIViewRepresentable {

    typealias UIViewType = UIScrollView
    
     
    @EnvironmentObject var cdm:calendardata
    @Binding var offset:CGFloat
    
    var height:CGFloat = 60
        
    func makeUIView(context: Context) -> UIScrollView {
        let scrollview = UIScrollView()
        scrollview.delegate = context.coordinator
        scrollview.contentSize = .init(width: 2400, height: cdm.calendar_events.count * 60)
        return scrollview
    }
    
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.contentSize = .init(width: 2400, height: cdm.calendar_events.count * 60)
        uiView.contentOffset.x = offset
        for subview in uiView.subviews {subview.removeFromSuperview()}
        let calendar_views = create_array()
        for calendar_view in calendar_views {
            uiView.addSubview(calendar_view)
        }
    }
    
    func makeCoordinator() -> CalendarViewCoordinator {
        let coordinator = CalendarViewCoordinator(owner: self)
        return coordinator
    }
    
    func create_array() -> [UIView]
    {
        if (cdm.calendar_events.count == 0) {return []}
        
        var subviews:[UIView] = []
        
        for i in 0..<cdm.calendar_events.count {
            let y = CGFloat(60 * i)
            for event in cdm.calendar_events[i] {
                let label = UILabel(frame: .init(x: event.hour * 100, y: y, width: event.num_hours * 100, height: 55))
                label.backgroundColor = .red
                label.layer.cornerRadius = 4
                label.text = event.name
                subviews.append(label)
            }
        }
        return subviews
    }
}


class CalendarViewCoordinator:NSObject, UIScrollViewDelegate {
    
    var owner:CalendarView
    
    init(owner:CalendarView)
    {
        self.owner = owner
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        owner.offset = scrollView.contentOffset.x
    }
}
        

