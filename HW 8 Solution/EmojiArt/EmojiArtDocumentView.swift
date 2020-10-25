//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Steve Liddle on 10/8/20.
//

import SwiftUI

struct EmojiArtDocumentView: View {

    // MARK: - Properties

    @ObservedObject var document: EmojiArtDocument
    
    @State private var chosenPalette: String
    
    @State private var selectedEmojis = Set<EmojiArt.Emoji>()

    private var isLoading: Bool {
        document.backgroundUrl != nil && document.backgroundImage == nil
    }
    // MARK: Initialization
    
    init(document: EmojiArtDocument) {
        self.document = document
        _chosenPalette = State(wrappedValue: document.defaultPaletteName)
    }
    
    // MARK: - Drag selection

    @GestureState private var gestureSelectionOffset: CGSize = .zero

    private var selectionOffset: CGSize {
        gestureSelectionOffset * zoomScale
    }

    private var selectionDragGesture: some Gesture {
        DragGesture()
            .updating($gestureSelectionOffset) { latestDragGestureValue, gestureSelectionOffset, transaction in
                gestureSelectionOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                selectedEmojis.forEach { emoji in
                    document.move(emoji: emoji, by: finalDragGestureValue.translation / zoomScale)
                }
            }
    }

    // MARK: - Pan document

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

    // MARK: - Zoom document

    @State private var steadyStateZoomScale: CGFloat = 1.0
    @GestureState private var gestureZoomScale: CGFloat = 1.0

    private var selectionZoomScale: CGFloat {
        selectedEmojis.count > 0
            ? gestureZoomScale
            : 1.0
    }

    private var zoomScale: CGFloat {
        selectedEmojis.count > 0
            ? steadyStateZoomScale
            : steadyStateZoomScale * gestureZoomScale
    }

    private var zoomGesture: some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, transaction in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { finalGestureScale in
                if selectedEmojis.count > 0 {
                    selectedEmojis.forEach { emoji in
                        document.scale(emoji: emoji, by: finalGestureScale)
                    }
                } else {
                    steadyStateZoomScale *= finalGestureScale
                }
            }
    }

    // MARK: - View body

    var body: some View {
        VStack {
            HStack {
                PaletteChooser(document: document, chosenPalette: $chosenPalette)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach((document.palettes[chosenPalette] ?? "").map { String($0) }, id: \.self) { emoji in
                            Text(emoji)
                                .font(Font.system(size: defaultEmojiSize))
                                .onDrag {
                                    NSItemProvider(object: emoji as NSString)
                                }
                        }
                    }
                }
                .layoutPriority(1)

                Spacer()

                Button(action: {
                    deleteSelectedEmojis()
                }) {
                    Image(systemName: "trash").imageScale(.large)
                }
            }
            .padding(.trailing)

            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        OptionalImage(uiImage: document.backgroundImage)
                            .scaleEffect(zoomScale)
                            .offset(panOffset)
                    )

                    if isLoading {
                        ProgressView()
                    } else {
                        ForEach(document.emojis) { emoji in
                            ZStack {
                                Rectangle()
                                    .stroke(selectedEmojis.contains(matching: emoji) ? Color.blue : Color.clear,
                                            lineWidth: 3)
                                    .frame(width: selectionBoxSize(for: emoji), height: selectionBoxSize(for: emoji))
                                Text(emoji.text)
                            }
                            .font(animatableWithSize: fontSize(for: emoji))
                            .position(position(for: emoji, in: geometry.size))
                            .gesture(selectedEmojis.contains(matching: emoji)
                                        ? selectionDragGesture
                                        : nil
                            )
                            .gesture(singleTapToSelect(emoji))
                        }
                    }
                }
                .clipped()
                .gesture(
                    doubleTapToZoom(in: geometry.size)
                        .simultaneously(with: singleTapToDeselect())
                        .exclusively(before: panGesture)
                        .exclusively(before: zoomGesture)
                )
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onReceive(document.$backgroundImage) { image in
                    withAnimation {
                        zoomToFit(image, in: geometry.size)
                    }
                }
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    var location = CGPoint(x: location.x, y: geometry.convert(location, from: .global).y)

                    location = location - (geometry.size / 2)
                    location = location - panOffset
                    location = location / zoomScale

                    return drop(providers: providers, location: location)
                }
            }
            .zIndex(-1)
        }
    }

    // MARK: - Private helpers

    private func clearSelection() {
        selectedEmojis.removeAll()
    }

    private func deleteSelectedEmojis() {
        selectedEmojis.forEach { emoji in
            document.delete(matching: emoji)
        }

        clearSelection()
    }

    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }

    private func drop(providers: [NSItemProvider], location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            document.setBackground(url: url)
        }

        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                document.add(emoji: string, at: location, size: defaultEmojiSize)
            }
        }

        return found
    }

    private func fontSize(for emoji: EmojiArt.Emoji) -> CGFloat {
        if selectedEmojis.contains(matching: emoji) {
            return emoji.fontSize * zoomScale * selectionZoomScale
        } else {
            return emoji.fontSize * zoomScale
        }
    }

    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        var location = emoji.location

        location = location * zoomScale
        location = location + (size / 2)
        location = location + panOffset

        if selectedEmojis.contains(matching: emoji) {
            location = location + selectionOffset
        }

        return location
    }

    private func selectionBoxSize(for emoji: EmojiArt.Emoji) -> CGFloat {
        emoji.fontSize * selectionBoxSizeFactor * zoomScale * selectionZoomScale
    }

    private func singleTapToDeselect() -> some Gesture {
        TapGesture()
            .onEnded {
                withAnimation {
                    clearSelection()
                }
            }
    }

    private func singleTapToSelect(_ emoji: EmojiArt.Emoji) -> some Gesture {
        TapGesture()
            .onEnded {
                withAnimation {
                    selectedEmojis.toggle(matching: emoji)
                }
            }
    }

    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let horizontalZoom = size.width / image.size.width
            let verticalZoom = size.height / image.size.height

            steadyStateZoomScale = min(horizontalZoom, verticalZoom)
            steadyStatePanOffset = .zero
        }
    }

    // MARK: - Drawing constants

    private let defaultEmojiSize: CGFloat = 40
    private let selectionBoxSizeFactor: CGFloat = 1.2
}

struct EmojiArtDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}
