//
//  ContentView.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

struct WaterView: View {
    @State private var percentageFilled: CGFloat = 0
    @State private var isBouncing: Bool = false
    @State private var valueDrinked: Double = 0
//    @Binding var percentageFilled: CGFloat
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Text("Total drinked: \(valueDrinked.formatted())L")
            Spacer()
            DropShapeFill(percentageFilled: $percentageFilled)
                .frame(width: 300, height: 350)
 
            Spacer()
            ButtonAF(action: {
                valueDrinked += 0.25
                valueDrinked = min(max(valueDrinked, 0), 2)
                percentageFilled += 0.125
            }, buttonText: "Add water", icon: "")
            .tint(.accentColor)
            
            ButtonAF(action: {
                percentageFilled = 0
                valueDrinked = 0
            }, buttonText: "Clear", icon: "")
                .tint(.red)
        }
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
                .fill(Color.cyan.opacity(percentageFilled < 0.5 ? 0 : 0.75))
                .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .animation(.easeInOut(duration: 2.5), value: percentageFilled)
        }
    }
}

#Preview {
    WaterView()
}
