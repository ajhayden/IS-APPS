//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Student on 10/8/20.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    
    // MARK: - Constants
    
    private static let untitled = "EmojiArtDocument.untitled"
    
    static let palette = "🐝🍎🚲🎈☀️☁️"
    
    // MARK: - Properties
    
    @Published private var emojiArt = EmojiArt() {
        didSet {
            UserDefaults.standard.set(emojiArt.json, forKey: EmojiArtDocument.untitled)
        }
    }
    
    @Published private(set) var backgroundImage: UIImage?
    
    // MARK: - Initialization
    
    init() {
        let jsonData = UserDefaults.standard.data(forKey: EmojiArtDocument.untitled)
        
        emojiArt = EmojiArt(json: jsonData) ?? EmojiArt()
        fetchBackgroundImageData()
    }
    
    // MARK: - Model acesss
    
    var emojis: [EmojiArt.Emoji] {
        emojiArt.emojis
    }
    
    // MARK: - Intent
    
    func add(emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func move(emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scale(emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    func setBackground(url: URL?) {
        emojiArt.backgroundUrl = url?.imageURL
        fetchBackgroundImageData()
    }
    
    // MARK: - Private helpers
    
    private func fetchBackgroundImageData() {
        backgroundImage = nil
        if let imageUrl = emojiArt.backgroundUrl {
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        if imageUrl == self.emojiArt.backgroundUrl {
                            self.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
