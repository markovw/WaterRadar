//
//  UserDataViewModel.swift
//  hydrated-app
//
//  Created by Vladislav on 30.05.2024.
//

import SwiftUI

class UserDataViewModel: ObservableObject {
    @Published var isGenderMenuOpen: Bool = false
    @Published var selectedButtonDefault: String = "Sex"
    @Published var selectedIconSex: String = "face.smiling"
    @Published var selectButtonColorSex: Color = .gray
    
    @Published var selectedWeight: Int = 0
    @Published var isWeightMenuOpen: Bool = false
    @Published var selectButtonColorWeight: Color = .gray
    @Published var selectedButtonWeight: String = "Weight"
}
