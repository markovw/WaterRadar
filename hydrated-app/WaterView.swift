//
//  ContentView.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

struct WaterView: View {
    var body: some View {
        
        
        Image(systemName: "drop")
            .resizable()
            .frame(width: 200, height: 300)
            .foregroundStyle(.cyan)
        
    }
}

#Preview {
    WaterView()
}
