//
//  ShapeView.swift
//  Concentration
//
//  Created by Student on 10/1/20.
//

import SwiftUI

struct CircleView: View {
    var body: some View {
        Circle()
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
            ))
            .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct RectangleView: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
            ))
            .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct SquareView: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
            ))
            .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct TriangleView: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 0.6)
            ))
            .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct BadgeView: View {
    var body: some View {
        Badge()
    }
}


struct ShapeView: View {
    var card: ConcentrationGame<String>.Card
    
    @State private var animatedBonusRemaining = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        
                    }
                    .opacity(0.4)
                    .padding()
                    .transition(.identity)
                    
                    bodyBuilder()
                        .font(systemFont(for: geometry.size))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1)
                                    .repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
            }
        }
        .aspectRatio(cardAspectRatio, contentMode: .fit)
    }
    
    private func angle(for degrees: Double) -> Angle {
        Angle.degrees(degrees * 360 - 90)
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * fontScaleFactor)
    }
    
    @ViewBuilder
    private func bodyBuilder() -> some View {
        if card.content == "circle" {
            CircleView()
                .padding(10)
        }
        else if card.content == "square" {
            RectangleView()
                .cornerRadius(10)
                .padding(15)
        }
        else if card.content == "badge" {
            BadgeView()
                .padding(10)
        }
        else if card.content == "rectangle" {
            RectangleView()
                .cornerRadius(10)
                .padding(15)
        }
        else if card.content == "squiggle" {
            SquiggleView()
        }
        else {
            RectangleView()
        }
        
    }
    
    // MARK: - Drawing constants
    
    private let cardAspectRatio: CGFloat = 9/10
    private let fontScaleFactor: CGFloat = 0.70
}

struct ShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeView(card: ConcentrationGame<String>.Card(isFaceUp: true, content: "square"))
            .padding(50)
    }
}

