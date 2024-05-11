//
//  WaterTrackerTabView.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

struct WaterTabView: View {
    var body: some View {
        TabView {
            WaterView()
                .tabItem { Label("Home", systemImage:  "house") }
            
            AnalysisView()
                .tabItem { Label("Analysis", systemImage:  "chart.bar.xaxis") }
            
            AccountView()
                .tabItem { Label("Profile", systemImage:  "person") }
        }
    }
}

#Preview {
    WaterTabView()
}
