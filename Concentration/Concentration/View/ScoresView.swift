//
//  GameScores.swift
//  Concentration
//
//  Created by Student on 9/23/20.
//

import SwiftUI

struct ScoresView: View {
    
    @ObservedObject var highScoreViewModel: HighScoreViewModel
    var hsString = "Never Played"
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("Overall High Score")
                        .bold()
                        .foregroundColor(Color.pink)
                        .font(.system(size: 20))
                    Text("Overall High Score: \(highScoreViewModel.overallHighScore)")
                        .bold()
                        .foregroundColor(Color.black)
                }
                .padding(.bottom, 5)
                
                Group {
                    VStack(alignment: .leading) {
                        Text("Emoji Mojo")
                            .bold()
                            .foregroundColor(Color.purple)
                            .font(.system(size: 20))
                            .padding(.bottom, 5)
                        Text("Animals: \(highScoreViewModel.userDefault.string(forKey: "emojiAnimalsHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("Bread: \(highScoreViewModel.userDefault.string(forKey: "emojiBreadsHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("Faces: \(highScoreViewModel.userDefault.string(forKey: "emojiFacesHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("Fruits: \(highScoreViewModel.userDefault.string(forKey: "emojiFruitsHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("Sports: \(highScoreViewModel.userDefault.string(forKey: "emojiSportsHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("Random: \(highScoreViewModel.userDefault.string(forKey: "emojiRandomHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.bottom, 5)
                
                Group {
                    VStack(alignment: .leading) {
                        Text("Temple Match")
                            .bold()
                            .foregroundColor(Color.green)
                            .font(.system(size: 20))
                            .padding(.bottom, 5)
                        Text("Utah: \(highScoreViewModel.userDefault.string(forKey: "templeUtah TemplesHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("Europe: \(highScoreViewModel.userDefault.string(forKey: "templeEuropean TemplesHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("South America: \(highScoreViewModel.userDefault.string(forKey: "emojiSouth American TemplesHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.bottom, 5)
                
                Group {
                    VStack(alignment: .leading) {
                        Text("Shape Scape")
                            .bold()
                            .foregroundColor(Color.blue)
                            .font(.system(size: 20))
                            .padding(.bottom, 5)
                        Text("Normal: \(highScoreViewModel.userDefault.string(forKey: "shapeNormalHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("Squiggles: \(highScoreViewModel.userDefault.string(forKey: "shapeSquigglesHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.bottom, 5)
                
                Group {
                    VStack(alignment: .leading) {
                        Text("Basketball Bounce")
                            .bold()
                            .foregroundColor(Color.orange)
                            .font(.system(size: 20))
                            .padding(.bottom, 5)
                        Text("NBA: \(highScoreViewModel.userDefault.string(forKey: "basketballNBAHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("College: \(highScoreViewModel.userDefault.string(forKey: "basketballCollegeHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                        Text("The Kids: \(highScoreViewModel.userDefault.string(forKey: "basketballThe KidsHighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(Color.black)
                    }
                }
                
                
            }
        }
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView(highScoreViewModel: HighScoreViewModel())
    }
}
