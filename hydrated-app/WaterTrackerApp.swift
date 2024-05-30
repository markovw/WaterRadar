//
//  hydrated_appApp.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

@main
struct WaterTrackerApp: App {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                UserDataView()
                    .environmentObject(UserDataModel())
            } else {
                WaterView()
                    .environmentObject(UserDataModel())
            }
            
        }
    }
}
