//
//  UserLogin.swift
//  hydrated-app
//
//  Created by Vladislav on 13.05.2024.
//

import SwiftUI

struct UserData: View {
    @State var isGenderMenuOpen: Bool = false
    @State var selectedButtonDefault: String = "Sex"
    @State var selectedIconSex: String = "face.smiling"
    @State private var selectButtonColor: Color = .blue.opacity(0.5)
    
    @State var isWeightMenuOpen: Bool = false
    @State var selectedButtonWeight: String = "Weight"
    @State var selectedWeight: Int = 0
    @State private var selectButtonColorWeight: Color = .blue.opacity(0.5)
    
    @State var normOfWater: Int = 2000
    
    @State var isDataFilled: Bool = false
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2)
                .ignoresSafeArea()
            Color.black.opacity(isGenderMenuOpen ? 0.4 : 0)
                .ignoresSafeArea()
            
            VStack {
                Text("\(normOfWater)ml")
                    .font(.system(size: 60))
                    .bold()
                    .padding(.bottom, 10)
                
                
                Text("Calculate your goal")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 50)
                
                SelectButton(action: { // gender select
                    withAnimation() {
                        isGenderMenuOpen.toggle()
                    }
                    selectedButtonDefault = selectedButtonDefault
                    checkDataFilled()
                }, buttonText: selectedButtonDefault, icon: selectedIconSex)
                //                .tint(isGenderMenuOpen ? .blue : .blue.opacity(0.5))
                .tint(selectButtonColor)
                
                SelectButton(action: { // weight select
                    withAnimation {
                        isWeightMenuOpen.toggle()
                    }
                }, buttonText: selectedButtonWeight, icon: "bag")
                .tint(selectButtonColorWeight)
            }
            .overlay (
                ZStack {
                    if isGenderMenuOpen {
                        GenderMenuView(isGenderMenuOpen: $isGenderMenuOpen, selectedButton: $selectedButtonDefault, selectedIconSex: $selectedIconSex, selectButtonColor: $selectButtonColor)
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
        }
    }
    
    func checkDataFilled() {
        if selectedButtonDefault != "Sex" && selectedButtonWeight != "Weight" {
            // Если обе кнопки заполнены, вычисляем норму воды
            normOfWater = waterNormCalculation(weight: selectedWeight, gender: selectedButtonDefault)
            isDataFilled = true
        } else {
            isDataFilled = false
        }
    }
}

struct GenderMenuView: View {
    @Binding var isGenderMenuOpen: Bool
    @Binding var selectedButton: String
    @Binding var selectedIconSex: String
    @Binding var selectButtonColor: Color
    
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
                selectButtonColor = .red
                withAnimation {
                    isGenderMenuOpen.toggle()
                }
            }, buttonText: "Male", icon: "brain.head.profile")
            .tint(.gray)
            
            MenuButton(action: {
                selectedButton = "Female"
                selectedIconSex = "eyes"
                selectButtonColor = .red
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
//            XDismissButton {
//                isWeightMenuOpen = false
//            }
            
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
                selectButtonColorWeight = .red
                selectedWeight = selectedWeight
                selectedButtonWeightDefault = "\(selectedWeight) kg"
            }, buttonText: "OK", icon: "")
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
    UserData(selectedButtonDefault: "Men")
}
