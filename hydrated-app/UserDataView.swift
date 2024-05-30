//
//  UserLogin.swift
//  hydrated-app
//
//  Created by Vladislav on 13.05.2024.
//

import SwiftUI

struct UserDataView: View {
    @EnvironmentObject var userDataModel: UserDataModel
    
    @AppStorage("selectedGender") var storedGender: String = "Sex"
    @AppStorage("selectedWeight") var storedWeight: Int = 0
    
    @State var isGenderMenuOpen: Bool = false
    @State var selectedButtonDefault: String = "Sex"
    @State var selectedIconSex: String = "face.smiling"
    @State var selectButtonColorSex: Color = .gray
    
    @State var isWeightMenuOpen: Bool = false
    @State var selectedButtonWeight: String = "Weight"
    @State var selectedWeight: Int = 0
    @State private var selectButtonColorWeight: Color = .gray
    @State var isDataFilled: Bool = false
    
    @Environment(\.dismiss) private var dismiss
        
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                Color.black.opacity(isGenderMenuOpen ? 0.4 : 0)
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
                            isGenderMenuOpen.toggle()
                        }
                        checkDataFilled()
                    }, buttonText: selectedButtonDefault, icon: selectedIconSex)
                    .tint(selectButtonColorSex)
                    
                    SelectButton(action: { // weight select
                        withAnimation {
                            isWeightMenuOpen.toggle()
                        }
                    }, buttonText: selectedButtonWeight, icon: "bag")
                    .tint(selectButtonColorWeight)
                    .navigationDestination(isPresented: $isDataFilled) {
                        WaterView(viewModel: WaterViewModel(userDataModel: UserDataModel())).navigationBarBackButtonHidden(true)
                    }
                }
                .overlay (
                    ZStack {
                        if isGenderMenuOpen {
                            GenderMenuView(isGenderMenuOpen: $isGenderMenuOpen, selectedButton: $selectedButtonDefault, selectedIconSex: $selectedIconSex, selectButtonColorSex: $selectButtonColorSex)
                                .zIndex(1)
                                .offset(y: 250)
                                .onDisappear {
                                    checkDataFilled()
                                }
                        }
                        if isWeightMenuOpen {
                            WeightMenuView(isWeightMenuOpen: $isWeightMenuOpen, selectedWeight: $selectedWeight, selectButtonColorWeight: $selectButtonColorWeight, selectedButtonWeightDefault: $selectedButtonWeight)
                            
                                .offset(y: 250)
                                .onDisappear {
                                    checkDataFilled()
                                }
                        }
                    }
                )
                .onAppear {
                    // Load stored values on appear
                    selectedButtonDefault = storedGender
                    selectedWeight = storedWeight
                    selectedButtonWeight = storedWeight > 0 ? "\(storedWeight) kg" : "Weight"
                    selectButtonColorSex = storedGender != "Sex" ? .accentColor : .gray
                    selectButtonColorWeight = storedWeight > 0 ? .accentColor : .gray
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
        if selectedButtonDefault != "Sex" && selectedButtonWeight != "Weight" {
            // Если обе кнопки заполнены, вычисляем норму воды
            userDataModel.normOfWater = waterNormCalculation(weight: selectedWeight, gender: selectedButtonDefault)
            isDataFilled = true
            
            storedGender = selectedButtonDefault
            storedWeight = selectedWeight
        } else {
            isDataFilled = false
        }
    }
}

struct GenderMenuView: View {
    @Binding var isGenderMenuOpen: Bool
    @Binding var selectedButton: String
    @Binding var selectedIconSex: String
    @Binding var selectButtonColorSex: Color
    
    var body: some View {
        Spacer()
        
        VStack {
            
            XDismissButton {
                withAnimation {
                    isGenderMenuOpen = false
                }
            }
            
            MenuButton(action: {
                selectedButton = "Male"
                selectedIconSex = "brain.head.profile"
                selectButtonColorSex = .accentColor
                withAnimation {
                    isGenderMenuOpen.toggle()
                }
            }, buttonText: "Male", icon: "brain.head.profile")
            .tint(.gray)
            
            MenuButton(action: {
                selectedButton = "Female"
                selectedIconSex = "eyes"
                selectButtonColorSex = .accentColor
                withAnimation {
                    isGenderMenuOpen.toggle()
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
    @Binding var isWeightMenuOpen: Bool
    @Binding var selectedWeight: Int
    @Binding var selectButtonColorWeight: Color
    @Binding var selectedButtonWeightDefault: String
    
    var body: some View {
        Spacer()
        
        VStack {
            Spacer()
            
            Picker(selection: $selectedWeight, label: Text("")) {
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
                isWeightMenuOpen = false
                selectedWeight = selectedWeight
                selectButtonColorWeight = .accentColor
                selectedButtonWeightDefault = "\(selectedWeight) kg"
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
    UserDataView(selectedButtonDefault: "Men")
        .environmentObject(UserDataModel())
}
