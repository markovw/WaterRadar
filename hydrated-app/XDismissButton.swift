//
//  XDismissButton.swift
//  hydrated-app
//
//  Created by Vladislav on 14.05.2024.
//

import SwiftUI

struct XDismissButton: View {
    
    @Binding var isGenderMenuOpen: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Circle()
                .fill(.gray.opacity(0.1))
                .frame(width: 45, height: 45)
                .overlay(
                    
                    Button {
                        withAnimation {
                            isGenderMenuOpen = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.label))
                            .imageScale(.large)
                            .frame(width: 35, height: 35)
                    }
                )
        }
        .padding()
    }
}

#Preview {
    XDismissButton(isGenderMenuOpen: .constant(false))
}
