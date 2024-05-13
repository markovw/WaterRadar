//
//  UserLogin.swift
//  hydrated-app
//
//  Created by Vladislav on 13.05.2024.
//

import SwiftUI

struct UserData: View {
    
    
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
                    
                }, buttonText: "Sex", icon: "face.smiling")
                
                SelectButton(action: {
                    
                }, buttonText: "Weight", icon: "bag")
            }
        }
    }
}

#Preview {
    UserData()
}
