//
//  hydrated_appApp.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

@main
struct WaterTrackerApp: App {
    @StateObject var userDataModel = UserDataModel()
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                UserDataView()
                    .environmentObject(userDataModel)
            } else {
                WaterView(viewModel: WaterViewModel(userDataModel: userDataModel))
                    .environmentObject(userDataModel)
            }
            
        }
    }
}
