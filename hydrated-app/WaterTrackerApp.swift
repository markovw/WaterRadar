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
    
    var body: some Scene {
        WindowGroup {
            WaterView(viewModel: WaterViewModel(userDataModel: UserDataModel()))
                .environmentObject(userDataModel)
//            WaterTabView()
        }
    }
}
