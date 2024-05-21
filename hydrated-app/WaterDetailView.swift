//
//  WaterDetailView.swift
//  hydrated-app
//
//  Created by Vladislav on 12.05.2024.
//

import SwiftUI

struct WaterQuantity: Identifiable {
    let id = UUID()
    let text: String
    let valueUserSee: Double
    var isPressed: Bool = false
    var waterQuantity: Double
    
}

struct WaterDetailView: View {
    @EnvironmentObject var userDataModel: UserDataModel
    @Binding var isShowingDetail: Bool
    @Binding var waterQuantity: Double
    @Binding var userValue: Double
    @State private var valueUserSet: Double = 0
    @State private var quantities: [WaterQuantity] = []
    
    var body: some View {
        ZStack(
            alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 350, height: 450)
                .foregroundStyle(.cyan.opacity(0.8))
                .shadow(color: .black.opacity(0.1), radius: 5)
            VStack {
                HStack(spacing: 30) {
                    ForEach($quantities) { $quantity in
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(quantity.isPressed ? .black.opacity(0.7) : .black.opacity(0.5))
                            .scaleEffect(quantity.isPressed ? 1.2 : 1.0)
                            .overlay {
                                Text(quantity.text)
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    quantity.isPressed.toggle()
                                    if quantity.isPressed {
                                        waterQuantity = quantity.waterQuantity
                                        valueUserSet = quantity.valueUserSee
                                        userValue = quantity.valueUserSee
                                        
                                        print("set to \(quantity.text) ml")
                                    }
                                }
                            }
                    }
                }
                .padding(.top, 35)
                
                Text("How much water did you drink?")
                    .font(.title)
                    .fontWeight(.medium)
                    .frame(width: 250)
                    .padding(.top, 50)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                
                ButtonAF(action: {
                    isShowingDetail = false
                }, buttonText: "Choose Quantity", icon: "")
                .padding(.top, 55)
                .tint(.white)
                
                ButtonAF(action: {
                    isShowingDetail = false
                }, buttonText: "Cancel", icon: "")
                .foregroundStyle(.white)
                .tint(.red.opacity(4.5))
            }
            .onAppear {
                waterQuantity = userDataModel.calculateNormOfWater()
                initializeQuantities()
            }
        }
    }
    private func initializeQuantities() {
        let calculatedWaterQuantity = userDataModel.calculateNormOfWater()
            quantities = [
                WaterQuantity(text: "250", valueUserSee: 250, waterQuantity: calculatedWaterQuantity),
                WaterQuantity(text: "350", valueUserSee: 350, waterQuantity: calculatedWaterQuantity * 1.4),
                WaterQuantity(text: "500", valueUserSee: 500, waterQuantity: calculatedWaterQuantity * 2)
            ]
        }
}
