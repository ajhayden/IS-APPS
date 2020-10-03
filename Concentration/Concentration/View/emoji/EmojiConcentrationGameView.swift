//
//  EmojiConcentrationGameView.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

struct EmojiConcentrationGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame
    var cardColor: Color = Color.black
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
     
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        Text("Score: \(emojiGame.score)")
                            .bold()
                            .foregroundColor(emojiGame.cardColor)
                            .font(.system(size: 20))
                        Text("High Score: \(emojiGame.userDefault.string(forKey: "emoji\(EmojiConcentrationGame.emojiThemes[emojiGame.indexOfTheme].name)HighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(.black)
                            .font(.system(size: 10))
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button("New Game") {
                            withAnimation(.easeInOut(duration: 0.75)) {
                                emojiGame.resetCards()
                            }
                        }
                        .foregroundColor(Color.white)
                        .frame(width: 110, height: 45)
                        .background(emojiGame.cardColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .font(.system(size: 19))
                        .padding(.bottom, 1)
                        
                        NavigationLink("Settings", destination: EmojiSettingsView(game: emojiGame))
                        .foregroundColor(Color.white)
                        .frame(width: 90, height: 35)
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .font(.system(size: 15))
                    }
                    
                }
                .padding(.top, 20)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                GeometryReader { geometry in
                    LazyVGrid(columns: columns(for: geometry.size) ) {
                        ForEach(emojiGame.cards) { card in
                            CardView(card: card)
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                        emojiGame.choose(card, gameType: "emoji", gameTheme: "\(EmojiConcentrationGame.emojiThemes[emojiGame.indexOfTheme].name)", score: "\(emojiGame.score)")
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
                                emojiGame.dealCards()
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .foregroundColor(emojiGame.cardColor)
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

struct EmojiConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(indexOfTheme: 0))
    }
}

//struct ProgressShapeView: View {
//    var value: Double
//    var width: CGFloat
//
//    var body: some View {
//        ZStack(alignment: .leading) {
//            Capsule()
//                .frame(width: 300, height: 15)
//                .foregroundColor(Color(white:0, opacity: 0.1)
//            Capsule()
//                .frame(width: width * CGFloat(value), height: 5)
//                .foregroundColor(.blue)
//
//        }
//    }
//}
//
//struct ProgressShapeView_Previews: PreviewProvider {
//    static var previews: some View {
//        GeometryReader { reader in
//            VStack(alignment: .leading) {
//                ProgressShapeView(value: 0, width: reader.size.width)
//                ProgressShaveView(value: 0.25, width: reader.size.width)
//            }
//        }
//    }
//}
