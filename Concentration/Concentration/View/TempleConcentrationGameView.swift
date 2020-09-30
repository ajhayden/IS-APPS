//
//  TempleConcentrationGameView.swift
//  Concentration
//
//  Created by Student on 9/28/20.
//

import SwiftUI

struct TempleConcentrationGameView: View {
    @ObservedObject var templeGame: TempleConcentrationGame
    var cardColor: Color = Color.black
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
     
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Score: \(templeGame.score)")
                        .bold()
                        .foregroundColor(cardColor)
                        .font(.system(size: 20))
                    Spacer()
                    Button("New Game") {
                        withAnimation(.easeInOut) {
                            templeGame.resetCards()
                        }
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 110, height: 60)
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .font(.system(size: 19))
                }
                .padding(.top, 10)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                GeometryReader { geometry in
                    LazyVGrid(columns: columns(for: geometry.size) ) {
                        ForEach(templeGame.cards) { card in
                            ImageCardView(card: card)
                                .transition(AnyTransition.offset(
                                    randomLocationOffScreen(for: geometry.size)
                                ))
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
//                                        templeGame.choose(card, gameType: "temple", gameTheme: "\(EmojiConcentrationGame.templeThemes[templeGame.indexOfTheme].name)")
                                    }
                            }
                        }
                    }
                    .padding(.top, 0)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.bottom, 0)
                    .foregroundColor(cardColor)
                }
            }
        }
    }
    

    func randomLocationOffScreen(for size: CGSize) -> CGSize {
        var randomSize = CGSize.zero
        let randomAngle = Double.random(in: 0..<Double.pi * 2)
        let scaleFactor = max(size.width, size.height) * 1.5
        
        randomSize.width = CGFloat(sin(randomAngle)) * scaleFactor
        randomSize.height = CGFloat(cos(randomAngle)) * scaleFactor
        
        return randomSize
    }
    
    //MARK: - Drawing constants
    
    private let desiredCardWidth: CGFloat = 100
}

struct TempleConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        TempleConcentrationGameView(templeGame: TempleConcentrationGame(indexOfTheme: 0))
    }
}
