//
//  ContentView.swift
//  HomeHelper
//
//  Created by MacMini on 12/05/23.
//
//Diseño https://dribbble.com/shots/21285943-Home-Helper-Mobile-IOS-App

import SwiftUI

extension Color{
    init(hex: UInt, alpha: Double = 1){
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha

        )
    }
}

struct ContentView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color.black)
    }
    
    var body: some View {
        TabView{
            HomeTab().tabItem{
                Label("Home", systemImage: "house")
            }
            RoomsTab().tabItem{
                Label("Rooms", systemImage: "squareshape.split.2x2")
            }
            DevicesTab().tabItem{
                Label("Devices", systemImage: "lightbulb")
            }
            AccountTab().tabItem{
                Label("Account", systemImage: "person.crop.circle")
            }
        }.accentColor(Color(hex: 0xffE2FFA3, alpha: 1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
