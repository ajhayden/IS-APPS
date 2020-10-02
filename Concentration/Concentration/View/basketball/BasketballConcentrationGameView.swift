//
//  BasketballConcentrationGameView.swift
//  Concentration
//
//  Created by Student on 10/1/20.
//

import SwiftUI

struct BasketballConcentrationGameView: View {
    @ObservedObject var basketballGame: BasketballConcentrationGame
    var cardColor: Color = Color.black
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
     
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        Text("Score: \(basketballGame.score)")
                            .bold()
                            .foregroundColor(cardColor)
                            .font(.system(size: 20))
                        Text("High Score: \(basketballGame.userDefault.string(forKey: "basketball\(BasketballConcentrationGame.basketballThemes[basketballGame.indexOfTheme].name)HighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(.black)
                            .font(.system(size: 10))
                    }
                    Spacer()
                    Button("New Game") {
                        withAnimation(.easeInOut) {
                            basketballGame.resetCards()
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
                        ForEach(basketballGame.cards) { card in
                            BasketballCardView(card: card)
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                        basketballGame.choose(card, gameType: "basketball", gameTheme: "\(BasketballConcentrationGame.basketballThemes[basketballGame.indexOfTheme].name)", score: "\(basketballGame.score)")
                                    }
                                }
                                .transition(AnyTransition.offset(
                                    randomLocationOffScreen(for: geometry.size)
                                ))
                        }
                    }
                    .onAppear() {
                        DispatchQueue.main.async {
                            withAnimation(Animation.easeInOut(duration: 1.5)) {
                                basketballGame.dealCards()
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

struct BasketballConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        BasketballConcentrationGameView(basketballGame: BasketballConcentrationGame(indexOfTheme: 0))
    }
}

