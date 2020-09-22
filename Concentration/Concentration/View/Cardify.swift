//
//  Cardify.swift
//  Concentration
//
//  Created by Student on 9/21/20.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cardCornerRadius).stroke()
                content
            } else {
                RoundedRectangle(cornerRadius: cardCornerRadius).fill()
            }
        }
    }
    
    private let cardCornerRadius: CGFloat = 10.0
}

struct Cardify_Previews: PreviewProvider {
    static var previews: some View {
        Text("🥨").modifier(Cardify(isFaceUp: true))
            .padding()
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
