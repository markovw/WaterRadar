//
//  UserDataViewModel.swift
//  hydrated-app
//
//  Created by Vladislav on 30.05.2024.
//

import SwiftUI

class UserDataViewModel: ObservableObject {
    @AppStorage("selectedGender") var storedGender: String = "Sex"
    @AppStorage("selectedWeight") var storedWeight: Int = 0
    
    @Published var isGenderMenuOpen: Bool = false
    @Published var selectedButtonDefault: String = "Sex"
    @Published var selectedIconSex: String = "face.smiling"
    @Published var selectButtonColorSex: Color = .gray
    
    @Published var selectedWeight: Int = 0
    @Published var isWeightMenuOpen: Bool = false
    @Published var selectButtonColorWeight: Color = .gray
    @Published var selectedButtonWeight: String = "Weight"
    
    func onAppear() {
        selectedButtonDefault = storedGender
        selectedWeight = storedWeight
        selectedButtonWeight = storedWeight > 0 ? "\(storedWeight) kg" : "Weight"
        selectButtonColorSex = storedGender != "Sex" ? .accentColor : .gray
        selectButtonColorWeight = storedWeight > 0 ? .accentColor : .gray
        
    }
    
    func buttonWeightOK() {
        isWeightMenuOpen = false
        selectedWeight = selectedWeight
        selectButtonColorWeight = .accentColor
        selectedButtonWeight = "\(selectedWeight) kg"
    }
    
    func waterNormCalculation(weight: Int, gender: String) -> Int {
        var waterNorm = 0
        
        if gender == "Male" {
            waterNorm = weight * 30
        } else {
            waterNorm = weight * 25
        }
        
        return waterNorm
    }
    
    func createGenderMenuButton(gender: String, icon: String) -> some View {
        MenuButton(action: {
            self.selectedButtonDefault = gender
            self.selectedIconSex = icon
            self.selectButtonColorSex = .accentColor
            withAnimation {
                self.isGenderMenuOpen.toggle()
            }
        }, buttonText: gender, icon: icon)
        .tint(.gray)
    }
    
}
