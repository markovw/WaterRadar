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
    
    @AppStorage("selectedGender") var storedGender: String = "Sex"
    @AppStorage("selectedWeight") var storedWeight: Int = 0
    
    
    

    
    
    @State var isDataFilled: Bool = false
    
    @Environment(\.dismiss) private var dismiss
        
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
                    
                    SelectButton(action: {
                        // gender select
                        withAnimation() {
                            userDataViewModel.isGenderMenuOpen.toggle()
                        }
                        checkDataFilled()
                    }, buttonText: userDataViewModel.selectedButtonDefault, icon: userDataViewModel.selectedIconSex)
                    .tint(userDataViewModel.selectButtonColorSex)
                    
                    SelectButton(action: { // weight select
                        withAnimation {
                            userDataViewModel.isWeightMenuOpen.toggle()
                        }
                    }, buttonText: userDataViewModel.selectedButtonWeight, icon: "bag")
                    .tint(userDataViewModel.selectButtonColorWeight)
                    .navigationDestination(isPresented: $isDataFilled) {
                        WaterView().navigationBarBackButtonHidden(true)
                    }
                }
                .overlay (
                    ZStack {
                        if userDataViewModel.isGenderMenuOpen {
                            GenderMenuView()
                                .zIndex(1)
                                .offset(y: 250)
                                .onDisappear {
                                    checkDataFilled()
                                }
                        }
                        if userDataViewModel.isWeightMenuOpen {
                            WeightMenuView()
                            
                                .offset(y: 250)
                                .onDisappear {
                                    checkDataFilled()
                                }
                        }
                    }
                )
                .onAppear {
                    // Load stored values on appear
                    userDataViewModel.selectedButtonDefault = storedGender
                    userDataViewModel.selectedWeight = storedWeight
                    userDataViewModel.selectedButtonWeight = storedWeight > 0 ? "\(storedWeight) kg" : "Weight"
                    userDataViewModel.selectButtonColorSex = storedGender != "Sex" ? .accentColor : .gray
                    userDataViewModel.selectButtonColorWeight = storedWeight > 0 ? .accentColor : .gray
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
    
    func checkDataFilled() {
        if userDataViewModel.selectedButtonDefault != "Sex" && userDataViewModel.selectedButtonWeight != "Weight" {
            // Если обе кнопки заполнены, вычисляем норму воды
            userDataModel.normOfWater = waterNormCalculation(weight: userDataViewModel.selectedWeight, gender: userDataViewModel.selectedButtonDefault)
            isDataFilled = true
            
            storedGender = userDataViewModel.selectedButtonDefault
            storedWeight = userDataViewModel.selectedWeight
        } else {
            isDataFilled = false
        }
    }
}

struct GenderMenuView: View {
    @EnvironmentObject var viewModel: UserDataViewModel
    
    var body: some View {
        Spacer()
        
        VStack {
            
            XDismissButton {
                withAnimation {
                    viewModel.isGenderMenuOpen = false
                }
            }
            
            MenuButton(action: {
                viewModel.selectedButtonDefault = "Male"
                viewModel.selectedIconSex = "brain.head.profile"
                viewModel.selectButtonColorSex = .accentColor
                withAnimation {
                    viewModel.isGenderMenuOpen.toggle()
                }
            }, buttonText: "Male", icon: "brain.head.profile")
            .tint(.gray)
            
            MenuButton(action: {
                viewModel.selectedButtonDefault = "Female"
                viewModel.selectedIconSex = "eyes"
                viewModel.selectButtonColorSex = .accentColor
                withAnimation {
                    viewModel.isGenderMenuOpen.toggle()
                }
            }, buttonText: "Female", icon: "eyes")
            .tint(.gray)
            
            Spacer()
        }
        .background(.white.opacity(1))
        .cornerRadius(25)
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height / 2.5)
    }
}

struct WeightMenuView: View {
    @EnvironmentObject var userDataViewModel: UserDataViewModel

    
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
                userDataViewModel.isWeightMenuOpen = false
                userDataViewModel.selectedWeight = userDataViewModel.selectedWeight
                userDataViewModel.selectButtonColorWeight = .accentColor
                userDataViewModel.selectedButtonWeight = "\(userDataViewModel.selectedWeight) kg"
            }, buttonText: "OK")
            .frame(maxWidth: 200)
            .tint(.blue)
//            .padding(.bottom, 50)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height / 2.5)
//        .background(.gray.opacity(1))
        .cornerRadius(25)
        .ignoresSafeArea(edges: .bottom)
    }
}

func waterNormCalculation(weight: Int, gender: String) -> Int {
    var waterNorm = 0
    
    if gender == "Male" {
        waterNorm = weight * 30
    } else {
        waterNorm = weight * 25
    }
    
    return waterNorm
}

#Preview {
    UserDataView()
        .environmentObject(UserDataModel())
        .environmentObject(UserDataViewModel())
}
