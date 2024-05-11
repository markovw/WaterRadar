//
//  ContentView.swift
//  hydrated-app
//
//  Created by Vladislav on 11.05.2024.
//

import SwiftUI

struct WaterView: View {
    var body: some View {
        
        VStack {
            Spacer()
            
            DropShape()
                .stroke(Color.blue, lineWidth: 6)
                .frame(width: 300, height: 400)
//            Image(systemName: "drop")
//                .resizable()
//                .frame(width: 200, height: 300)
//                .foregroundStyle(.cyan)
            Spacer()
            ButtonAF(action: {
                
            }, buttonText: "Add water", icon: "")
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

#Preview {
    WaterView()
}
