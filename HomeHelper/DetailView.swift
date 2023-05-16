//
//  DetailView.swift
//  HomeHelper
//
//  Created by MacMini on 16/05/23.
//

import SwiftUI

struct SliderView3: View {
    @Binding var value: Double
    
    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100
    var thumbColor: Color = .orange
    var minTrackColor: Color = .yellow
    var maxTrackColor: Color = .gray
    
    var body: some View {
        GeometryReader { gr in
            let thumbHeight = gr.size.height * 1.1
            let thumbWidth = gr.size.width * 0.03
            let radius = gr.size.height * 0.5
            let minValue = gr.size.width * 0.015
            let maxValue = (gr.size.width * 0.98) - thumbWidth
            
            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            
            ZStack {
                Rectangle()
                    .foregroundColor(maxTrackColor)
                    .frame(width: gr.size.width, height: gr.size.height * 0.95)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                HStack {
                    Rectangle()
                        .foregroundColor(minTrackColor)
                    .frame(width: sliderVal, height: gr.size.height * 0.95)
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: radius))
                HStack {
                    ZStack {
                        Circle()
                            .foregroundColor(thumbColor)
                            .frame(width: 50, height: thumbHeight)
                            .offset(x: sliderVal)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { v in
                                        if (abs(v.translation.width) < 0.1) {
                                            self.lastCoordinateValue = sliderVal
                                        }
                                        if v.translation.width > 0 {
                                            let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                            self.value = ((nextCoordinateValue - minValue) / scaleFactor)  + lower
                                        } else {
                                            let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                            self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                        }
                                   }
                        )
                        Image(systemName: "lightbulb").rotationEffect(Angle(degrees: 90))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
        }
    }
}


struct DetailView: View {
    @State private var isOn = true
    @State private var value: Double = 0
    
    let elementos = ["Lamp", "Home theatre", "Temperature"]
    
    var body: some View {
        NavigationStack {
            ZStack{
                AsyncImage(url: URL(string: "https://picsum.photos/id/834/400/900")).ignoresSafeArea()
                Color.black.opacity(0.6).ignoresSafeArea()
                VStack{
                    ZStack{
                        //
                    }.frame(height: 50)
                    HStack{
                        Image(systemName: "arrow.backward").foregroundColor(.white).font(.largeTitle)
                        Text("Guest Mode").foregroundColor(.white).font(.title)
                        Spacer()
                        Toggle("", isOn: $isOn)
                    }.padding()
                    SliderView3(value: $value).frame(width: 450, height: 50)
                        .rotationEffect(Angle(degrees: 270))
                        .position(x: 50, y: 250)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(0..<3){ index in
                                Text(elementos[index]).foregroundColor(.white).font(.largeTitle)
                            }
                        }
                    }.position(x: 220, y: 200)
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
