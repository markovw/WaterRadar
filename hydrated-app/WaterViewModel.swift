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
