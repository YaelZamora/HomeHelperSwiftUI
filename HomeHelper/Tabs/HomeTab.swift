//
//  HomeTab.swift
//  HomeHelper
//
//  Created by MacMini on 12/05/23.
//

import SwiftUI

struct CardView : View{
    var body: some View{
        Rectangle().fill(Color.pink)
            .frame(width: 300, height: 300)
            .border(Color.black)
            .cornerRadius(30)
            .padding()
    }
}

struct HomeTab: View {
    @State private var index = 0
    
    let textos = ["Light", "Speaker", "TV", "Garage", "Bathroom"]
    let labels = ["18%", "95%", "50%", "10%", "80%"]
    let iconos = ["lightbulb", "homepodmini", "tv", "car", "toilet"]
    
    var body: some View {
        ZStack{
            Color(hex: 0xff000000, alpha: 1).ignoresSafeArea()
            VStack{
                HStack{
                    Image(systemName: "line.3.horizontal").foregroundColor(.white).font(.largeTitle)
                    Spacer()
                    Image(systemName: "bell").foregroundColor(.white).font(.largeTitle)
                }.padding()
                HStack{
                    Text("Living Room").foregroundColor(.white).bold()
                    Spacer()
                    Text("Guest mode").foregroundColor(.white)
                }.padding()
                
                //Card
                VStack {
                    TabView(selection: $index){
                        ForEach((0..<3), id: \.self){ index in
                            CardView()
                        }
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }.frame(height: 300)
                
                //Indicators
                HStack(spacing: 2) {
                    ForEach((0..<3), id: \.self) { index in
                        Rectangle()
                            .fill(index == self.index ? Color(hex: 0xffE2FFA3, alpha: 1) : Color.white.opacity(0.5))
                            .frame(height: 5)

                    }
                }.padding([.horizontal], 100)
                
                HStack{
                    Text("Connected Devices").foregroundColor(.white)
                    Spacer()
                    Text("View All").underline().foregroundColor(.white)
                }.padding()
                
                ScrollView(.horizontal){
                    HStack(spacing: 20){
                        ForEach(0..<5){index in
                            CardMini(text: textos[index], icon: iconos[index], label: labels[index])
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}

struct CardMini: View {
    @State private var toggle = true
    var text : String
    var icon : String
    var label : String
    
    var body: some View {
        ZStack {
            Rectangle().fill(.pink)
                .frame(width: 200, height: 200)
                .cornerRadius(30)
            Text(text).foregroundColor(.white)
                .bold()
                .position(x: 50, y: 20)
            Toggle("", isOn: $toggle).position(x: 80, y: 50)
            Label(label, systemImage: icon).foregroundColor(.white)
                .bold()
                .font(.title)
                .position(x: 70, y: 120)
        }.frame(width: 200, height: 200)
    }
}
