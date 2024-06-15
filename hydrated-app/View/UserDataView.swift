//
//  UserLogin.swift
//  hydrated-app
//
//  Created by Vladislav on 13.05.2024.
//

import SwiftUI

struct UserDataView: View {
    @EnvironmentObject var userDataModel: UserDataModel
    @EnvironmentObject var userDataViewModel: UserDataViewModel

    @Environment(\.dismiss) private var dismiss
    
    @State var isDataFilled: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                Color.black.opacity(userDataViewModel.isGenderMenuOpen ? 0.4 : 0)
                    .ignoresSafeArea()
                
                VStack {
                    Text("\(userDataModel.normOfWater.formatted(.number.grouping(.never)))ml")
                        .font(.system(size: 60))
                        .bold()
                        .padding(.bottom, 10)
                    
                    Text("Calculate your goal")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 50)
                    
                    SelectButton(action: { // gender select
                        withAnimation(.smooth(duration: 0.3)) {
                            userDataViewModel.isGenderMenuOpen.toggle()
                        }
                    }, buttonText: userDataViewModel.selectedButtonDefault, icon: userDataViewModel.selectedIconSex)
                    .tint(userDataViewModel.selectButtonColorSex)
                    
                    SelectButton(action: { // weight select
                        withAnimation {
                            userDataViewModel.isWeightMenuOpen.toggle()
                        }
                    }, buttonText: userDataViewModel.selectedButtonWeight, icon: "bag")
                    .tint(userDataViewModel.selectButtonColorWeight)
                }
                .navigationDestination(isPresented: $isDataFilled) {
                    WaterView().navigationBarBackButtonHidden(true)
                }
                .overlay (
                    ZStack {
                        if userDataViewModel.isGenderMenuOpen {
                            GenderMenuView()
                                .transition(.move(edge: .bottom))
                                .zIndex(1)
                                .offset(y: 270)
                                .onDisappear {
                                    checkDataFilled()
                                }
                        }
                        if userDataViewModel.isWeightMenuOpen {
                            WeightMenuView()
                                .transition(.move(edge: .bottom))
                                .offset(y: 250)
                                .onDisappear {
                                    checkDataFilled()
                                }
                        }
                    }
                )
                .onAppear { // Load stored values on appear
                    userDataViewModel.onAppear()
                    checkDataFilled()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    dismiss()
                }
            }
        }
    }
    
    func checkDataFilled() { // need to refactor
        if userDataViewModel.selectedButtonDefault != "Sex" && userDataViewModel.selectedButtonWeight != "Weight" {
            // Если обе кнопки заполнены, вычисляем норму воды
            userDataModel.normOfWater = userDataViewModel.waterNormCalculation(weight: userDataViewModel.selectedWeight, gender: userDataViewModel.selectedButtonDefault)
            isDataFilled = true
            
            userDataViewModel.storedGender = userDataViewModel.selectedButtonDefault
            userDataViewModel.storedWeight = userDataViewModel.selectedWeight
        } else {
            isDataFilled = false
        }
    }
}

struct GenderMenuView: View {
    @EnvironmentObject private var viewModel: UserDataViewModel
    
    var body: some View {
        Spacer()
        
        VStack {
            XDismissButton {
                withAnimation {
                    viewModel.isGenderMenuOpen = false
                }
            }
            viewModel.createGenderMenuButton(gender: "Male", icon: "brain.head.profile")
            viewModel.createGenderMenuButton(gender: "Female", icon: "eyes")
            viewModel.createGenderMenuButton(gender: "Altooshka", icon: "poweroutlet.type.k")
            
            Spacer()
        }
        .background(.white.opacity(1))
        .cornerRadius(25)
        .frame(width: UIScreen.main.bounds.width,
               height: 450)
    }
}

struct WeightMenuView: View {
    @EnvironmentObject private var userDataViewModel: UserDataViewModel
    
    var body: some View {
        Spacer()
        
        VStack {
            Spacer()
            
            Picker(selection: $userDataViewModel.selectedWeight, label: Text("")) {
                ForEach(30..<201) {
                    Text("\($0)").tag($0)
                }
            }
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(width: 150, height: 150)
            .clipped()
            .padding(.top, 50)
            
            ButtonAF(action: {
                userDataViewModel.buttonWeightOK()
            }, buttonText: "OK")
            .frame(maxWidth: 200)
            .tint(.blue)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height / 2.5)
        .cornerRadius(25)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    UserDataView()
        .environmentObject(UserDataModel())
        .environmentObject(UserDataViewModel())
}
