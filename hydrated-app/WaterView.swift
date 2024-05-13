//
//  ContentView.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

struct User {
    @State private var gender: String
    @State private var weight: Int
}

struct WaterView: View {
    @State private var percentageFilled: CGFloat = 1
    @State private var isBouncing: Bool = false
    @State private var isShowingWaterDetailView = false
    @State private var dropped = false
    @State var valueDrinked: Double = 0
    @State var waterQuantity: Double = 0.125
    @State var isPressed: Bool = true
    @State var userValue: Double = 0.25 // value for default
    @State var maxWaterValue = 0

    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                
                NavigationLink(destination: UserData()) {
                    Text("Total Drinked – \(valueDrinked.formatted())L")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.black)
                }
                
                Spacer()
                
                ZStack {
                    DropShapeFill(percentageFilled: $percentageFilled)
                        .frame(width: 300, height: 380)
                        .overlay (
                            Rectangle()
                                .fill(.clear)
                                .contentShape(Rectangle()) // projects the figure even if it is hidden
                        )
                        .onTapGesture {
                            if !dropped {
                                percentageFilled = 0
                                dropped = true
                            }
                            percentageFilled += waterQuantity
                            valueDrinked += userValue
                            valueDrinked = min(max(valueDrinked, 0), 5)
                        }
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
                    WaterDetailView(isShowingDetail: $isShowingWaterDetailView, waterQuantity: $waterQuantity, valueDrinked: $valueDrinked, userValue: $userValue)
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

enum Gender: String {
    case Male = "Male"
    case Female = "Female"
}

func waterNormCalculation(weight: Int, gender: Gender) -> Int {
    var waterNorm = 0
    
    if gender == .Male {
        waterNorm = weight * 30
    } else {
        waterNorm = weight * 25
    }
    
    return waterNorm
}

#Preview {
    WaterView()
}


