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
        ZStack(alignment: .top) {
            VStack {
                HStack(spacing: 30) {
                    ForEach($quantities.indices, id: \.self) { index in
                        let quantity = quantities[index]
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(quantity.isPressed ? Color.accentColor.opacity(0.5) : Color.accentColor.opacity(0.35))
                            .scaleEffect(quantity.isPressed ? 1.15 : 1.0)
                            .overlay {
                                Text(quantity.text)
                                    .font(.title3)
                                    .foregroundStyle(quantity.isPressed ? .white : .white)
                                    .fontWeight(.medium)
                            }
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    waterQuantity = userDataModel.calculateNormOfWater()
                                    updateQuantities(for: index)
                                }
                            }
                    }
                }
            }
            .onAppear {
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
    
    private func updateQuantities(for selectedIndex: Int) {
            for index in quantities.indices {
                quantities[index].isPressed = index == selectedIndex
            }
            waterQuantity = quantities[selectedIndex].waterQuantity
            valueUserSet = quantities[selectedIndex].valueUserSee
            userValue = quantities[selectedIndex].valueUserSee
            
            print("set to \(quantities[selectedIndex].text) ml")
        }
}

#Preview {
    WaterDetailView(isShowingDetail: .constant(true), waterQuantity: .constant(250), userValue: .constant(250))
        .environmentObject(UserDataModel())
}
