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
    @EnvironmentObject var userDataModel: UserDataModel
    @State private var percentageFilled: CGFloat = UserDefaults.standard.double(forKey: "Percentage")
    @AppStorage("UserDrinked") var valueDrinked: Double = 250 // text valueDrinked
    @AppStorage("DroppedTF") private var dropped = false
    @State private var isShowingWaterDetailView = false
    @State private var animationOnClick = false
    @State private var finalAnimation = false
    @AppStorage("waterQuantity") var waterQuantity: Double = 0.125 // for fill the trim
    @AppStorage("UserValueOnTap") var userValue: Double = 250 // value for default for user
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                ZStack {
                    DropShapeFill(percentageFilled: $percentageFilled)
                        .frame(width: animationOnClick ? 350 : 300, height: animationOnClick ? 430 : 380)
                        .rotationEffect(finalAnimation ? .degrees(180) : .degrees(0))
                        .overlay (
                            Rectangle()
                                .fill(.clear)
                                .contentShape(Rectangle()) // projects the figure even if it is hidden
                        )
                        .overlay (
                            NavigationLink(destination: UserData()            .navigationBarBackButtonHidden(true)) {
                                Text("\(valueDrinked.formatted(.number.grouping(.never)))ml")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundStyle(.blue)
                            }
                        )
                        .onTapGesture {
                            if !dropped {
                                percentageFilled = 0
                                dropped = true
                            }
                            percentageFilled += waterQuantity
                            valueDrinked += userValue
                            UserDefaults.standard.set(percentageFilled, forKey: "Percentage")
                            valueDrinked = min(max(valueDrinked, 0), 6000)
                            
                            if Int(valueDrinked) > userDataModel.normOfWater / 1000 {
                                withAnimation(.spring(duration: 0.5)) {
                                    animationOnClick = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                                    withAnimation(.snappy(duration: 0.65)) {
                                        animationOnClick = false
                                    }
                                }
                            } else if Int(valueDrinked) >= userDataModel.normOfWater / 1000 {
                                withAnimation {
                                    finalAnimation = true
                                }
                            }
                        }
                        .onLongPressGesture {
                            percentageFilled = 1
                            valueDrinked = 0
                            dropped = false
                            print("--- Water Cleared ---")
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: 450)
                
                Spacer()
                WaterDetailView(isShowingDetail: $isShowingWaterDetailView, waterQuantity: $waterQuantity, userValue: $userValue)
                    .padding()
                
            }
        }
        .blur(radius: isShowingWaterDetailView ? 7 : 0)
        .overlay(
            ZStack {
                if isShowingWaterDetailView {
                    WaterDetailView(isShowingDetail: $isShowingWaterDetailView, waterQuantity: $waterQuantity, userValue: $userValue)
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
        .environmentObject(UserDataModel())
}
