//
//  ContentView.swift
//  EmojiArt
//
//  Created by Student on 10/8/20.
//

import SwiftUI

struct EmojiArtDocumentView: View {

    // MARK: - Properties

    @ObservedObject var document: EmojiArtDocument

    @State private var selectedEmojis = Set<EmojiArt.Emoji>()

    private var isLoading: Bool {
        document.backgroundUrl != nil && document.backgroundImage == nil
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

    // MARK: - View body

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

                    if isLoading {
//                        Image(systemName: "hourglass").imageScale(.large).spinning()
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
                            .font(animatableWithSize: emoji.fontSize * zoomScale)
                            .position(position(for: emoji, in: geometry.size))
                            .gesture(
                                selectionDragGesture.exclusively(
                                    before: singleTapToSelect(emoji)
                                )
                            )
                        }
                    }
                }
                .clipped()
                // I modified .gesture() a bit.  I want double-tap and single-tap on the
                // background to happen together (if they double-tap, I also want the
                // single-tap behavior of deselecting; if they single-tap, I just want
                // to clear the selection).  But in the case of pan and zoom, we want to
                // sequence them in the given order, hence the use of .exclusively(before:).
                .gesture(
                    doubleTapToZoom(in: geometry.size)
                        .simultaneously(with: singleTapToDeselect())
                        .exclusively(before: panGesture)
                        .exclusively(before: zoomGesture)
                )
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    var location = CGPoint(x: location.x, y: geometry.convert(location, from: .global).y)

                    location = location - (geometry.size / 2)
                    location = location - panOffset
                    location = location / zoomScale

                    return drop(providers: providers, location: location)
                }
            }
        }
    }

    // MARK: - Private helpers

    private func clearSelection() {
        selectedEmojis.removeAll()
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
        emoji.fontSize * selectionBoxSizeFactor * zoomScale
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
