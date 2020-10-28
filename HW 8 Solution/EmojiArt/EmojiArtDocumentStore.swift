//
//  EmojiArtDocumentStore.swift
//  EmojiArt
//
//  Created by Steve Liddle on 10/23/20.
//

import SwiftUI
import Combine

class EmojiArtDocumentStore: ObservableObject {

    // MARK: - Constants

    private static let defaultName = "Untitled"

    // MARK: - Properties

    let name: String

    // This is the heart of the store.  We keep a dictionary of documents (keys)
    // and document names (string values).  This may seem a little backwards.
    // Why not have the names be the keys and the documents the values?  There
    // are a few other places in the code where this structure is a bit easier
    // to use.  But of course you could swap keys and values if you prefer.
    @Published private var documentNames = [EmojiArtDocument : String]()

    private var autosave: AnyCancellable?

    // MARK: - Initialization

    init(named name: String = EmojiArtDocumentStore.defaultName) {
        self.name = name
        let defaultsKey = "EmojiArtDocumentStore.\(name)"

        documentNames = Dictionary(fromPropertyList: UserDefaults.standard.object(forKey: defaultsKey))
        autosave = $documentNames.sink { names in
            UserDefaults.standard.set(names.asPropertyList, forKey: defaultsKey)
        }
    }

    // MARK: - Computed properties

    var documents: [EmojiArtDocument] {
        documentNames.keys.sorted { documentNames[$0] ?? "" < documentNames[$1] ?? "" }
    }

    // MARK: - Document store CRUD

    func addDocument(named name: String = EmojiArtDocumentStore.defaultName) {
        documentNames[EmojiArtDocument()] = name
    }

    func name(for document: EmojiArtDocument) -> String {
        if documentNames[document] == nil {
            documentNames[document] = EmojiArtDocumentStore.defaultName
        }

        return documentNames[document] ?? EmojiArtDocumentStore.defaultName
    }

    func setName(_ name: String, for document: EmojiArtDocument) {
        documentNames[document] = name
    }

    func removeDocument(_ document: EmojiArtDocument) {
        documentNames[document] = nil
    }
}

// MARK: - Dictionary property-list extension

extension Dictionary where Key == EmojiArtDocument, Value == String {
    var asPropertyList: [String : String] {
        var uuidToName = [String : String]()

        for (key, value) in self {
            uuidToName[key.id.uuidString] = value
        }

        return uuidToName
    }

    init(fromPropertyList plist: Any?) {
        self.init()
        let uuidToName = plist as? [String : String] ?? [:]

        for uuid in uuidToName.keys {
            self[EmojiArtDocument(id: UUID(uuidString: uuid))] = uuidToName[uuid]
        }
    }
}
