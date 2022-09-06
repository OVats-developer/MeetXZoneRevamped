//
//  PreferenceManager.swift
//  MeetXZoneRevamped
//
//  Created by Oshin Vats on 05/09/2022.
//

import SwiftUI

class PreferenceManager:ObservableObject {
    
    @Published var sh:Int
    @Published var eh:Int
    @Published var sm:Int
    @Published var em:Int
    
    @Published var sc:Color = Color.init(red: 0.3, green: 0.7, blue: 1, opacity: 0.75)
    
    init()
    {
        let l_sh = UserDefaults.standard.integer(forKey: "sh")
        let l_eh = UserDefaults.standard.integer(forKey: "eh")
        
        sm = UserDefaults.standard.integer(forKey: "sm")
        em = UserDefaults.standard.integer(forKey: "em")

        
        if ((l_sh == 0) && (l_eh == 0)) {sh = 8; eh = 17}
        else {sh = l_sh; eh = l_eh}
        
        var red = UserDefaults.standard.double(forKey: "red")
        var green = UserDefaults.standard.double(forKey: "green")
        var blue = UserDefaults.standard.double(forKey: "blue")
        var op = UserDefaults.standard.double(forKey: "op")

        if (red == 0)
        {
            if (green == 0)
            {
                if (blue == 0)
                {
                    red = 0.3
                    green = 0.7
                    blue = 1
                    op = 0.75
                }
            }
        }
        sc = .init(red: red, green: green, blue: blue, opacity: op)
    }
    
    func save(sh:Int, sm:Int, eh:Int, em:Int, sc:Color)
    {
        DispatchQueue.main.async {
            
            self.sh = sh
            self.sm = sm
            self.eh = eh
            self.em = em
            self.sc = sc
            
            UserDefaults.standard.set(sh, forKey: "sh")
            UserDefaults.standard.set(sm, forKey: "sm")
            UserDefaults.standard.set(eh, forKey: "eh")
            UserDefaults.standard.set(em, forKey: "em")
            
            let components = sc.cgColor!.components!
            
            UserDefaults.standard.set(components[0], forKey: "red")
            UserDefaults.standard.set(components[1], forKey: "green")
            UserDefaults.standard.set(components[2], forKey: "blue")
            UserDefaults.standard.set(components[3], forKey: "op")

        }
    }
    
}
