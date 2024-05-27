//
//  WaterViewModel.swift
//  hydrated-app
//
//  Created by Vladislav on 16.05.2024.
//

import SwiftUI

class UserDataModel: ObservableObject {
    @Published var normOfWater: Int = 2000
    
    func calculateNormOfWater() -> Double {
        let result = (Double(normOfWater) / 0.25) / 1000
        print(result)
        let calculation = 1 / result
        print(calculation)
        return calculation
    }
}

class WaterViewModel: ObservableObject {
    @Published var percentageFilled: CGFloat = UserDefaults.standard.double(forKey: "Percentage")
    @AppStorage("UserDrinked") var valueDrinked: Double = 250 // text valueDrinked
    @AppStorage("DroppedTF") var dropped = false
    @Published var isShowingWaterDetailView = false
    @Published var animationOnClick = false
    @Published var finalAnimation = false
    @AppStorage("waterQuantity") var waterQuantity: Double = 0.125 // for fill the trim
    @AppStorage("UserValueOnTap") var userValue: Double = 250 // value for default for user
//    @EnvironmentObject var userDataModel: UserDataModel

    private var userDataModel: UserDataModel
    
    init(userDataModel: UserDataModel) {
            self.userDataModel = userDataModel
        }
    
    func onTapGesture() {
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
                        self.animationOnClick = false
                    }
                }
            } else if Int(valueDrinked) >= userDataModel.normOfWater / 1000 {
                withAnimation {
                    finalAnimation = true
                }
            }
        }
    
        func onLongPressGesture() {
            percentageFilled = 1
            valueDrinked = 0
            dropped = false
            print("--- Water Cleared ---")
        }
}
