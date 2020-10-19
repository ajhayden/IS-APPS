//
//  ContentView.swift
//  EmojiArt
//
//  Created by Student on 10/8/20.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    @State var emojisSelectedSet = Set<EmojiArt.Emoji>()
    
    @State private var selectedEmojisSteadyStatePanOffset: CGSize = .zero
    @GestureState private var selectedEmojisGesturePanOffset: CGSize = .zero
    
    private var selectedEmojisPanOffset: CGSize {
        (selectedEmojisSteadyStatePanOffset + selectedEmojisGesturePanOffset) * zoomScale
    }
    
    private var selectedEmojisPanGesture: some Gesture {
        DragGesture()
            .updating($selectedEmojisGesturePanOffset) { latestDragGestureValue, selectedEmojisGesturePanOffset, transaction in
                selectedEmojisGesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                selectedEmojisSteadyStatePanOffset = selectedEmojisSteadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
                
                for emoji in emojisSelectedSet {
                    self.document.move(emoji: emoji, by: selectedEmojisSteadyStatePanOffset)
                }
                selectedEmojisSteadyStatePanOffset = .zero
            }
    }
    
    @State private var steadyStatePanOffset: CGSize = .zero
    @GestureState private var gesturePanOffset: CGSize = .zero
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }
    
    private var panGesture: some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, transaction in
                gesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                steadyStatePanOffset = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
            }
    }
    
    @State private var steadyStateZoomScale: CGFloat = 1.0
    @GestureState private var gestureZoomScale: CGFloat = 1.0
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
    private var zoomGesture: some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, transaction in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { finalGestureScale in
                steadyStateZoomScale *= finalGestureScale
            }
    }
    
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
                            .offset(panOffset)
                    )
                    .gesture(doubleTapToZoom(in: geometry.size))
                        
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .border(Color.blue, width: emojisSelectedSet.contains(matching: emoji) ? 4 : 0)
                            .cornerRadius(5)
                            .font(animatableWithSize: emoji.fontSize * zoomScale)
                            .position(self.position(for: emoji, in: geometry.size))
                            .gesture(selectedEmojisPanGesture)
                            .onTapGesture {
                                if let index = emojisSelectedSet.firstIndex(matching: emoji) {
                                    emojisSelectedSet.remove(emojisSelectedSet[index])
                                } else {
                                    emojisSelectedSet.insert(emoji)
                                }
                            }
                    }
                }
                .clipped()
                .gesture(tapToUnselectEmojis())
                .gesture(panGesture)
                .gesture(zoomGesture)
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    var location = CGPoint(x: location.x, y: geometry.convert(location, from: .global).y)
                    
                    location = CGPoint(x: location.x - geometry.size.width / 2, y: location.y - geometry.size.height / 2)
                    location = CGPoint(x: location.x - panOffset.width, y: location.y - panOffset.height)
                    location = CGPoint(x: location.x / zoomScale, y: location.y / zoomScale)
                    
                    return drop(providers: providers, location: location)
                }
            }
        }
    }
    
    private func tapToUnselectEmojis() -> some Gesture {
        TapGesture(count: 1)
            .onEnded {
                emojisSelectedSet.removeAll()
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
        location = CGPoint(x: location.x + panOffset.width, y: location.y + panOffset.height)
        
        if emojisSelectedSet.contains(matching: emoji) {
            location = CGPoint(x: location.x + selectedEmojisPanOffset.width, y: location.y + selectedEmojisPanOffset.height)
        }
        
        return location
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let horizontalZoom = size.width / image.size.width
            let verticalZoom = size.height / image.size.height
            
            steadyStateZoomScale = min(horizontalZoom, verticalZoom)
            steadyStatePanOffset = .zero
        }
    }
    
    // MARK: -Drawing constants
    
    private let defaultEmojiSize: CGFloat = 80
}
