//
//  WaterDetailView.swift
//  hydrated-app
//
//  Created by Vladislav on 12.05.2024.
//

import SwiftUI

struct WaterDetailView: View {
    @Binding var isShowingDetail: Bool
    @Binding var waterQuantity: Double
    @Binding var valueUserSet: Double
    
    @State var tempWaterQuantity: Double
    @State var tempValueUserSet: Double
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 350, height: 450)
                .foregroundStyle(.cyan.opacity(0.8))
                .shadow(color: .black.opacity(0.1), radius: 5)
            VStack {
                HStack {
                    Circle()
                        .frame(width: 90, height: 90)
                        .foregroundStyle(.black.opacity(0.5))
                        .overlay {
                            Text("250")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                        }
                        .onTapGesture {
                            tempWaterQuantity = 0.125
                            valueUserSet = 0.25
                            print("set to 250 ml")
                        }
                        
                    Circle()
                        .frame(width: 90, height: 90)
                        .foregroundStyle(.black.opacity(0.5))
                        .overlay {
                            Text("350")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                        }
                    
                    Circle()
                        .frame(width: 90, height: 90)
                        .foregroundStyle(.black.opacity(0.5))
                        .overlay {
                            Text("500")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                        }
                        .onTapGesture {
                            tempWaterQuantity = 0.25
                            valueUserSet = 0.5
                            
                            print("set to 500 ml")
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
                    waterQuantity = tempWaterQuantity
                    isShowingDetail = false
                }, buttonText: "Choose Quantity", icon: "")
                .padding(.top, 55)
                .tint(.white)
                
                ButtonAF(action: {
                    isShowingDetail = false
                    tempWaterQuantity = waterQuantity
                    valueUserSet = tempValueUserSet
                }, buttonText: "Cancel", icon: "")
                .foregroundStyle(.white)
                .tint(.red.opacity(4.5))
            }
        }
    }
}

#Preview {
    WaterDetailView(isShowingDetail: .constant(true), waterQuantity: .constant(0.25), valueUserSet: .constant(0.25), tempWaterQuantity: 0.0, tempValueUserSet: 0.25)
}

