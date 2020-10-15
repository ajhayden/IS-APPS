//
//  ContentView.swift
//  EmojiArt
//
//  Created by Student on 10/8/20.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    @State private var zoomScale: CGFloat = 2
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtDocument.palette.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: defaultEmojiSize))
                            .onDrag {
                                NSItemProvider(object: emoji as NSString)
                            }
                    }
                }
            }
            .padding(.horizontal)
            
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        OptionalImage(uiImage: document.backgroundImage)
                            .scaleEffect(zoomScale)
                    )
                    .gesture(doubleTapToZoom(in: geometry.size))
                        
                    
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(animatableWithSize: emoji.fontSize * zoomScale)
                            .position(self.position(for: emoji, in: geometry.size))
                    }
                }
                .clipped()
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    var location = CGPoint(x: location.x, y: geometry.convert(location, from: .global).y)
                    
                    location = CGPoint(x: location.x - geometry.size.width / 2, y: location.y - geometry.size.height / 2)
                    location = CGPoint(x: location.x / zoomScale, y: location.y / zoomScale)
                    
                    return drop(providers: providers, location: location)
                }
            }
        }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation(.linear(duration: 1)) {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func drop(providers: [NSItemProvider], location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            self.document.setBackground(url: url)
        }
        
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.add(emoji: string, at: location, size: defaultEmojiSize)
            }
        }
        return found
    }
    
    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        var location = emoji.location
        
        location = CGPoint(x: location.x * zoomScale, y: location.y * zoomScale)
        location = CGPoint(x: location.x + size.width / 2, y: location.y + size.height / 2)
        
        return location
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let horizontalZoom = size.width / image.size.width
            let verticalZoom = size.height / image.size.height
            
            zoomScale = min(horizontalZoom, verticalZoom)
        }
    }
    
    // MARK: -Drawing constants
    
    private let defaultEmojiSize: CGFloat = 40
}
