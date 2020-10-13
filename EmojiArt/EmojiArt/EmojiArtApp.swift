//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Student on 10/8/20.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}
