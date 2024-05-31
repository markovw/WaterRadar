//
//  ContentView.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

struct User {
    @State private var gender: String
    @State private var weight: Int
}

struct WaterView: View {

    @EnvironmentObject var viewModel: WaterViewModel

    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                ZStack {
                    DropShapeFill(percentageFilled: $viewModel.percentageFilled)
                        .frame(width: viewModel.animationOnClick ? 350 : 300, height: viewModel.animationOnClick ? 430 : 380)
                        .rotationEffect(viewModel.finalAnimation ? .degrees(180) : .degrees(0))
                        .overlay (
                            Rectangle()
                                .fill(.clear)
                                .contentShape(Rectangle()) // projects the figure even if it is hidden
                        )
                        .overlay (
                            NavigationLink(destination: UserDataView().environmentObject(UserDataViewModel()).navigationBarBackButtonHidden(true)) {
                                Text("\(viewModel.valueDrinked.formatted(.number.grouping(.never)))ml")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundStyle(.blue)
                            }
                        )
                        .onTapGesture {
                            viewModel.onTapGesture()
                        }
                        .onLongPressGesture {
                            viewModel.onLongPressGesture()
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: 450)
                
                
                Spacer()
                WaterDetailView(isShowingDetail: $viewModel.isShowingWaterDetailView, waterQuantity: $viewModel.waterQuantity, userValue: $viewModel.userValue)
                    .padding()
                
            }
//            .background(.cyan.opacity(0.5))
            .background(Color("backgroundColor"))
            
        }
        .blur(radius: viewModel.isShowingWaterDetailView ? 7 : 0)
        .overlay(
            ZStack {
                if viewModel.isShowingWaterDetailView {
                    WaterDetailView(isShowingDetail: $viewModel.isShowingWaterDetailView, waterQuantity: $viewModel.waterQuantity, userValue: $viewModel.userValue)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding()
                }
            }
        )
    }
}

struct DropShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY - rect.height * 0.1),
                      control1: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.4),
                      control2: CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.1))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY),
                      control1: CGPoint(x: rect.minX, y: rect.maxY - rect.height * 0.1),
                      control2: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.4))
        path.closeSubpath()
        
        return path
    }
}

struct DropShapeFill: View {
    @Binding var percentageFilled: CGFloat
    
    var body: some View {
        ZStack {
            DropShape()
                .trim(from: 0, to: percentageFilled)
                .fill(Color.cyan.opacity(percentageFilled < 0.5 ? 0.3 : 0.75))
                .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .animation(.easeInOut(duration: 2.5), value: percentageFilled)
        }
    }
}

#Preview {
    
    WaterView()
        .environmentObject(WaterViewModel(userDataModel: UserDataModel()))
        .environmentObject(UserDataModel())
}
