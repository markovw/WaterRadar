//
//  ButtonAF.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

struct ButtonAF: View {
    let action: () -> Void
        let buttonText: String
        let icon: String
        
    var body: some View {
        Button(action: action) {
            Label(title: { Text(buttonText) },
                  icon: { Image(systemName: icon) })
            .frame(width: 250)
            
        }
        .buttonStyle(.bordered)
        .controlSize(.extraLarge)
//        .tint(.accentColor)
//        .padding(.bottom, 20)
        .fontWeight(.bold)
    }
}

struct SelectButton: View {
    let action: () -> Void
    let buttonText: String
    let icon: String
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(buttonText)
                Spacer()
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding()
            .frame(width: 200, height: 40)
        }
        .buttonStyle(.bordered)
        .controlSize(.extraLarge)
        .fontWeight(.bold)
        
    }
}

struct MenuButton: View {
    let action: () -> Void
    let buttonText: String
    let icon: String
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(buttonText)
                    .foregroundStyle(.black)
                    .padding(10)
                Spacer()
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.black)
                    .padding(10)
            }
            .padding(.vertical, 5)
        }
        .cornerRadius(20)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .buttonStyle(.bordered)
        .fontWeight(.bold)
        
    }
}
#Preview {
    SelectButton(action: {
        
    }, buttonText: "Sex", icon: "face.smiling")
    
}

#Preview {
    MenuButton(action: {
        
    }, buttonText: "Test", icon: "brain")
}
//
//
//#Preview {
//    ButtonAF(action: {
//        
//    }, buttonText: "Press Button", icon: "house")
//    

