//
//  Pie.swift
//  Concentration
//
//  Created by Student on 9/17/20.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        var p = Path()
        
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
             center: center,
             radius: radius,
             startAngle: startAngle,
             endAngle: endAngle,
             clockwise: clockwise
        )
        p.addLine(to: center)
        
        return p
    }
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(105-90),
            clockwise: true)
            .foregroundColor(.orange)
            .opacity(0.4)
    }
}
