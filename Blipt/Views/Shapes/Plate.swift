//
//  Plate.swift
//  Blipt
//
//  Created by Travis Baksh on 4/17/23.
//

import SwiftUI

struct Plate: Shape {
  @State private var isHovered = false
  
  func path(in rect: CGRect) -> Path {
    let diameter = min(rect.width, rect.height)
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = diameter / 2
    let startAngle = Angle(degrees: 0)
    let endAngle = Angle(degrees: 360)
    
    var path = Path()
    path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    path.move(to: CGPoint(x: center.x - radius, y: center.y))
    path.addLine(to: CGPoint(x: center.x + radius, y: center.y))
    
    return path
  }
  
  var body: some View {
    ZStack {
      Plate()
        .fill(Color(red: 230/255, green: 230/255, blue: 230/255))
        .frame(width: 24, height: 24)
        .overlay(
          Plate()
            .stroke(Color.gray, lineWidth: 2)
            .frame(width: 24, height: 24)
        )
      
      Circle()
        .fill(isHovered ? Color.white.opacity(0.1) : Color.clear)
        .frame(width: 24, height: 24)
    }
    .gesture(
      DragGesture()
        .onChanged { _ in
          isHovered = true
        }
        .onEnded { _ in
          isHovered = false
        }
    )
  }
}
