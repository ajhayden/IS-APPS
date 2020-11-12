//
//  ContentView.swift
//  FileSystemExplorer
//
//  Created by Student on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(readFileContents())
            .padding()
        Text(writeHomeDirectoryFile())
            .padding()
    }

    private func readFileContents() -> String {
        if let url = urlForFile() {
            if let stringData = try? Data(contentsOf: url) {
                return String(decoding: stringData, as: UTF8.self)
            }
        }

        return "(nothing)"
    }

    private func urlForFile() -> URL? {
        return try? FileManager.default.url(
            for: FileManager.SearchPathDirectory.documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        .appendingPathComponent("testfile")
        .appendingPathExtension("txt")
    }

    private func writeHomeDirectoryFile() -> String {
        do {
            if let url = urlForFile() {
                let fileData = Data(url.absoluteString.utf8)

                try fileData.write(to: url, options: .atomic)

                return url.absoluteString
            }
        } catch {
            print("There was an error")
        }

        return "There was an error"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
