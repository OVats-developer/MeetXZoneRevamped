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
                       width:CGFloat,
                       height:CGFloat)
    {
        self._offset = offset
        mainview = UIScrollView()
        mainview.contentSize = CGSize(width: width, height: height)
        mainview.translatesAutoresizingMaskIntoConstraints = false
        
        let hoster = UIHostingController(rootView: content())
        let view = hoster.view!
        view.translatesAutoresizingMaskIntoConstraints = false
        mainview.addSubview(view)
        view.topAnchor.constraint(equalTo: mainview.topAnchor).isActive = true

    }
    
    func makeUIView(context: Context) -> UIScrollView {
        mainview.contentOffset.x = offset
        mainview.delegate = context.coordinator
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
        owner.offset = scrollView.contentOffset.x
    }
    
}

#else

#endif
