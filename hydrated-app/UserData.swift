//
//  UserLogin.swift
//  hydrated-app
//
//  Created by Vladislav on 13.05.2024.
//

import SwiftUI

struct UserData: View {
    @State var isGenderMenuOpen: Bool = false
    @State var selectedButton: String? = nil
    
    @State var isFocused: [Bool] = Array(repeating: false, count: 3)
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2)
                .ignoresSafeArea()
            VStack {
                Text("2000ml")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                Text("Calculate your goal")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 50)
                
                
                SelectButton(action: {
                    withAnimation() {
                        isGenderMenuOpen.toggle()
                    }
                    selectedButton = "Sex"
                }, buttonText: "Sex", icon: "face.smiling")
                .tint(isGenderMenuOpen ? .blue : .gray)
                
                SelectButton(action: {
                    isGenderMenuOpen.toggle()
                    
                }, buttonText: "Weight", icon: "bag")
                .tint(isGenderMenuOpen ? .blue : .gray)
                
                
            }
            if isGenderMenuOpen {
                GenderMenuView(isGenderMenuOpen: $isGenderMenuOpen).zIndex(1)
                    .offset(y: 250)
            }
        }
    }
}

struct GenderMenuView: View {
    @Binding var isGenderMenuOpen: Bool
    
    var body: some View {
        Spacer()
        
        VStack {
            
            XDismissButton(isGenderMenuOpen: $isGenderMenuOpen)
            
            MenuButton(action: {
                
            }, buttonText: "Male", icon: "brain.head.profile")
            .tint(.red)
            
            MenuButton(action: {
                
            }, buttonText: "Female", icon: "eyes")
            .tint(.red)
            
            Spacer()
        }
        .background(.white.opacity(1))
        .cornerRadius(25)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)

        
    }
}

#Preview {
    UserData()
}

#Preview {
    GenderMenuView(isGenderMenuOpen: .constant(false))
}
