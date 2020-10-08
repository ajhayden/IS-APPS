//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Student on 10/8/20.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    static let palette = "🐝🍎🚲🎈☀️☁️"
    
    @Published private(set) var backgroundImage: UIImage?
    
    // MARK: Intent
    
    func setBackground(url: URL?) {
        // Fetch the UIImage based on this URL
    }
}
