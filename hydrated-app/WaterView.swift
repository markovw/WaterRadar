//
//  ContentView.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

struct WaterView: View {
    @State private var percentageFilled: CGFloat = 1
    @State private var isBouncing: Bool = false
    @State var valueDrinked: Double = 0
    @State private var isShowingWaterDetailView = false
    @State private var dropped = false
    @State var waterQuantity: Double = 0.125
    @State var valueUserSet: Double = 0.25
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Total Drinked – \(valueDrinked.formatted())L")
                    .font(.title2)
                    .bold()
                
                
                Spacer()
                
                DropShapeFill(percentageFilled: $percentageFilled)
                    .frame(width: 300, height: 350)
                
                    .onTapGesture {
                        if !dropped {
                            percentageFilled = 0
                            dropped = true
                        }
                        percentageFilled += waterQuantity
                        valueDrinked += valueUserSet
                        valueDrinked = min(max(valueDrinked, 0), 2)
                    }
                
                Spacer()
                
                ButtonAF(action: {
                    withAnimation {
                        isShowingWaterDetailView.toggle()
                    }
                }, buttonText: "Add water", icon: "")
                .tint(.accentColor)
                
                // clear button
                ButtonAF(action: {
                    percentageFilled = 1
                    valueDrinked = 0
                    dropped = false
                    
                }, buttonText: "Clear", icon: "")
                .tint(.red)
                .padding(.bottom, 20)
            }
        }
        .blur(radius: isShowingWaterDetailView ? 7 : 0)
        .overlay(
            ZStack {
                if isShowingWaterDetailView {
                    WaterDetailView(isShowingDetail: $isShowingWaterDetailView, waterQuantity: $waterQuantity, valueUserSet: $valueUserSet, tempWaterQuantity: waterQuantity, tempValueUserSet: valueUserSet)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding()
                }
            }
        )
    }
}
    

struct DropShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY - rect.height * 0.1),
                      control1: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.4),
                      control2: CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.1))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY),
                      control1: CGPoint(x: rect.minX, y: rect.maxY - rect.height * 0.1),
                      control2: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.4))
        path.closeSubpath()
        
        return path
    }
}

struct DropShapeFill: View {
    @Binding var percentageFilled: CGFloat
    
    var body: some View {
        ZStack {
            DropShape()
                .trim(from: 0, to: percentageFilled)
                .fill(Color.cyan.opacity(percentageFilled < 0.5 ? 0.3 : 0.75))
                .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .animation(.easeInOut(duration: 2.5), value: percentageFilled)
        }
    }
}

#Preview {
    WaterView()
}
