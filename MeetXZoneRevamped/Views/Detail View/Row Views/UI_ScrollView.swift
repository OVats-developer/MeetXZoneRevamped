//
//  UI_ScrollView.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 02/09/2022.
//

import Foundation
import SwiftUI
import UIKit


#if os(iOS)
struct UI_ScrollView:UIViewRepresentable {
    
    typealias UIViewType = UIScrollView
    @Binding var offset:CGFloat
    
    var mainview:UIScrollView
    
    init<Content:View>(offset:Binding<CGFloat>,
                       @ViewBuilder content: () -> Content,
                       height:CGFloat)
    {
        self._offset = offset
        
        self.mainview = .init()
        mainview.translatesAutoresizingMaskIntoConstraints = false
        mainview.contentSize = .init(width: 2400, height: height)
        
        let hoster = UIHostingController(rootView: content())
        let view = hoster.view!
        view.translatesAutoresizingMaskIntoConstraints = false
        
        mainview.addSubview(view)
        view.topAnchor.constraint(equalTo: mainview.topAnchor).isActive = true
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        mainview.contentOffset.x = offset
        mainview.delegate = context.coordinator
        mainview.showsHorizontalScrollIndicator = false
        mainview.showsVerticalScrollIndicator = false
        return mainview
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.contentOffset.x = offset
    }
    
    func makeCoordinator() -> UIScrollViewCoordinator {
        return UIScrollViewCoordinator(owner: self)
    }
    
}


class UIScrollViewCoordinator:NSObject, UIScrollViewDelegate
{
    var owner:UI_ScrollView
    
    init(owner: UI_ScrollView) {
        self.owner = owner
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0
        owner.offset = scrollView.contentOffset.x
    }
    
}

#else

#endif
