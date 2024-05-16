//
//  WaterDetailView.swift
//  hydrated-app
//
//  Created by Vladislav on 12.05.2024.
//

import SwiftUI

struct WaterQuantity: Identifiable {
    let id = UUID()
    let value: Double
    let text: String
    let valueUserSee: Double
    var isPressed: Bool = false
}

struct WaterDetailView: View {
    @Binding var isShowingDetail: Bool
    @Binding var waterQuantity: Double
    @Binding var valueDrinked: Double
    @Binding var userValue: Double
    
    @State private var valueUserSet: Double = 0
    @State private var previousWaterQuantity: Double
    @State private var previousValueUserSet: Double
    @State private var quantities: [WaterQuantity] = [
        WaterQuantity(value: 0.125, text: "250", valueUserSee: 0.25),
        WaterQuantity(value: 0.175, text: "350", valueUserSee: 0.35),
        WaterQuantity(value: 0.25, text: "500", valueUserSee: 0.5)
    ]
    
    init(isShowingDetail: Binding<Bool>, waterQuantity: Binding<Double>, valueDrinked: Binding<Double>, userValue: Binding<Double>) {
        self._isShowingDetail = isShowingDetail
        self._waterQuantity = waterQuantity
        self._valueDrinked = valueDrinked
        self._userValue = userValue
        _previousWaterQuantity = State(initialValue: waterQuantity.wrappedValue)
        _previousValueUserSet = State(initialValue: userValue.wrappedValue)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
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
                                        waterQuantity = quantity.value
                                        valueUserSet = quantity.value
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
                    waterQuantity = previousWaterQuantity
                    previousWaterQuantity = valueUserSet 
                }, buttonText: "Cancel", icon: "")
                .foregroundStyle(.white)
                .tint(.red.opacity(4.5))
            }
        }
    }
}



#Preview {
    WaterDetailView(isShowingDetail: .constant(false), waterQuantity: .constant(0), valueDrinked: .constant(0), userValue: .constant(0))
}
