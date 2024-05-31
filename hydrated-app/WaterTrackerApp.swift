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
    @StateObject var viewModel = WaterViewModel(userDataModel: UserDataModel())
    @StateObject var userDataModel = UserDataModel()

    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                UserDataView()
                    .environmentObject(userDataModel)
                    .environmentObject(viewModel)
                    .environmentObject(UserDataViewModel())
            } else {
                WaterView()
                    .environmentObject(userDataModel)
                    .environmentObject(viewModel)
            }   
        }
    }
}
