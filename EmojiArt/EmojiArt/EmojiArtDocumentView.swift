//
//  ContentView.swift
//  EmojiArt
//
//  Created by Student on 10/8/20.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var viewModel: EmojiArtDocument
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtDocument.palette.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: defaultEmojiSize))
                        
                    }
                }
            }
            .padding(.horizontal)
        }
        Color.white.overlay(
            Group {
                if let image = viewModel.backgroundImage {
                    Image(viewModel.backgroundImage)
                }
            }
        )
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .onDrop(of: ["public.image"], isTargeted: nil) { providers, locaton in
                return drop()
            }
    }
    
    private func drop(provider: [NSItemProvider]) -> Bool {
        let found = providers.loadFirstObject(ofType: URL.self) { url in
        }
        return true
    }
    // MARK: -Drawing constants
    
    private let defaultEmojiSize: CGFloat = 40
}
