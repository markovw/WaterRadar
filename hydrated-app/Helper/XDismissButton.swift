//
//  XDismissButton.swift
//  hydrated-app
//
//  Created by Vladislav on 14.05.2024.
//

import SwiftUI

struct XDismissButton: View {
    var action: () -> Void
    var body: some View {
        HStack {
            Spacer()
            
            Circle()
                .fill(.gray.opacity(0.1))
                .frame(width: 45, height: 45)
                .overlay(
                    Button(action: action) {
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

struct BackButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.gray.opacity(0.1))
                    .frame(width: 45, height: 45)
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color(.label))
                    .imageScale(.large)
                    .frame(width: 35, height: 35)
            }
        }
    }
}

#Preview {
    XDismissButton {
    }
}

#Preview {
    BackButton {
    }
}
