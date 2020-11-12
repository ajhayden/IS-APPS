//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Steve Liddle on 10/8/20.
//

import SwiftUI
import Combine

class EmojiArtDocument: ObservableObject, Hashable, Equatable, Identifiable {
    static func == (lhs: EmojiArtDocument, rhs: EmojiArtDocument) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: UUID
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // MARK: - Properties

    @Published private var emojiArt = EmojiArt()
    @Published private(set) var backgroundImage: UIImage?
    @Published var steadyStateZoomScale: CGFloat = 1.0
    @Published var steadyStatePanOffset: CGSize = .zero
    
    private var autosaveCancellable: AnyCancellable?
    
    private var fetchImageCancellable: AnyCancellable?

    // MARK: - Initialization

    init(id: UUID? = nil) {
        self.id = id ?? UUID()
        
        let defaultsKey = "EmojiArtDocument.\(self.id.uuidString)"
        
        let jsonData = readFileContents(fileName: defaultsKey)

        emojiArt = EmojiArt(json: jsonData) ?? EmojiArt()
        autosaveCancellable = $emojiArt.sink { emojiArt in
            self.writeEmojiFile(data: emojiArt.json, fileName: defaultsKey)
            self.listFiles()
        }
        fetchBackgroundImageData()
    }

    // MARK: - Model access

    var backgroundUrl: URL? {
        emojiArt.backgroundUrl
    }

    var emojis: [EmojiArt.Emoji] {
        emojiArt.emojis
    }

    // MARK: - Intents

    func add(emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }

    func delete(matching emoji: EmojiArt.Emoji) {
        emojiArt.delete(matching: emoji)
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
            fetchImageCancellable?.cancel()
            fetchImageCancellable = URLSession.shared
                .dataTaskPublisher(for: imageUrl)
                .map { data, response in UIImage(data: data) }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
                .assign(to: \EmojiArtDocument.backgroundImage, on: self)
        }
    }
    
    private func listFiles() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            print("FileURLs")
            print(fileURLs)
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    
    private func urlForFile(fileName: String) -> URL? {
        return try? FileManager.default.url(
            for: FileManager.SearchPathDirectory.documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        .appendingPathComponent(fileName)
        .appendingPathExtension("json")
    }
    
    private func writeEmojiFile(data: Data?, fileName: String) {
        do {
            if let url = urlForFile(fileName: fileName) {
                if let fileData = data {
                    try fileData.write(to: url, options: .atomic)
                }
            }
        } catch {
            print("There was an error with write")
        }
    }
    
    private func readFileContents(fileName: String) -> Data? {
        if let url = urlForFile(fileName: fileName) {
            if let data = try? Data(contentsOf: url) {
                return data
            }
        }
        print("There was an error with read")
        return nil
    }
}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y))}
}
