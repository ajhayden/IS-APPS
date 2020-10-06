//
//  TimerView.swift
//  Concentration
//
//  Created by Student on 10/3/20.
//

import SwiftUI

//extension TaskListViewController {
//
//}
//
//@objc func updateTimer() {
//  // 1
//  guard let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows else {
//    return
//  }
//
//  for indexPath in visibleRowsIndexPaths {
//    // 2
//    if let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell {
//      cell.updateTime()
//    }
//  }
//}
//
//func createTimer() {
//  // 1
//  if timer == nil {
//    // 2
//    timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                 target: self,
//                                 selector: #selector(updateTimer),
//                                 userInfo: nil,
//                                 repeats: true)
//  }
//}

//struct Timer: Shape {
//    var startAngle: Angle
//    var endAngle: Angle
//    var clockwise = false
//
//    var animatableData: AnimatablePair<Double, Double> {
//        get {
//            AnimatablePair(startAngle.radians, endAngle.radians)
//        }
//        set {
//            startAngle = Angle.radians(newValue.first)
//            endAngle = Angle.radians(newValue.second)
//        }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        let center = CGPoint(x: rect.midX, y: rect.midY)
//        let radius = min(rect.width, rect.height) / 2
//        let start = CGPoint(
//            x: center.x + radius * cos(CGFloat(startAngle.radians)),
//            y: center.y + radius * sin(CGFloat(startAngle.radians))
//        )
//        var p = Path()
//
//        p.move(to: center)
//        p.addLine(to: start)
//        p.addArc(
//             center: center,
//             radius: radius,
//             startAngle: startAngle,
//             endAngle: endAngle,
//             clockwise: clockwise
//        )
//        p.addLine(to: center)
//
//        return p
//    }
//}
//
//struct Timer_Previews: PreviewProvider {
//    static var previews: some View {
//        Timer(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(105-90),
//            clockwise: true)
//            .foregroundColor(.orange)
//            .opacity(0.4)
//    }
//}

// Notes from clas. Image resizable() and then aspectRatio(contentMode: .fit) also .scale to fill
// Make the job easy. Cut all images to be exactly that same size. Cut the aspect ratio for exactly what you want for the images.
//func getHighScore() -> String {
//    let highScore = UserDefaults.standard.integer(forKey: "highScore")
//
//    if highScore > 0 {
//        return "\(highScore)"
//    }
//
//    return "Never Played"
//}
//
// He put UserDefaults.standard.setValue(5, forKey: "highScore") in the Preview provider
//
// He has a settings to input pairs of cards and sound enabled that just saves to userDefaults
// You could also give them an input just before they go into the next theme
// You need an overall highscore. Anytime you update the score compare it against the other score
// You could use a progress bar at the bottom of the page
// You could put the pie on top of the image

struct ProgressShapeView: View {
    var value: Double
    var width: CGFloat

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: 300, height: 15)
                .foregroundColor(Color(white:0, opacity: 0.1))
            Capsule()
                .frame(width: width * CGFloat(value), height: 5)
                .foregroundColor(.blue)

        }
    }
}

struct ProgressShapeView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                ProgressShapeView(value: 0, width: reader.size.width)
                ProgressShapeView(value: 0.25, width: reader.size.width)
                ProgressShapeView(value: 0.75, width: reader.size.width)
                ProgressShapeView(value: 0.79, width: reader.size.width)
                Text("I hate this")
                
            }
        }
    }
}

