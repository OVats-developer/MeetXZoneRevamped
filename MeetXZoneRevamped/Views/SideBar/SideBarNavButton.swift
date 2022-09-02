//
//  SideBarNavButton.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 31/08/2022.
//

import SwiftUI

struct SideBarNavButton: View {
    
    var width:CGFloat
    var show:Bool
    
    var body: some View {
        if (show == true)
        {
            if #available(iOS 16, macOS 13, *)
            {
                HStack {
                    Spacer()
                    maincontent()
                    Spacer()
                }
            }
            else
            {
                NavigationLink {
                    Text("Testing")
                } label: {
                    maincontent()
                }
            }
        }
    }
    
    
    @ViewBuilder
    func maincontent() -> some View {
        Rectangle()
            .foregroundColor(.green)
            .cornerRadius(10)
            .frame(width: width * 0.6, height:40)
            .overlay {
                Text("Continue")
                    .fontWeight(.black)
                    .foregroundColor(.white)
            }
    }
}

struct SideBarNavButton_Previews: PreviewProvider {
    static var previews: some View {
        SideBarNavButton(width: 200, show: true)
    }
}
