//
//  ContentView.swift
//  MappedScriptures
//
//  Created by Student on 11/17/20.
//

import SwiftUI

struct MapScripturesView: View {

    var body: some View {
        NavigationView {
            List {
                ForEach(GeoDatabase.shared.volumes()) { volume in
                    NavigationLink(volume.citeFull, destination:
                                    ScriptureBrowser(bookId: volume.id))
                }
            }
            .navigationTitle("Standard Works")
        }
    }
}

struct MapScripturesView_Previews: PreviewProvider {
    static var previews: some View {
        MapScripturesView()
    }
}

struct ScriptureBrowser: View {
    var bookId: Int?
    var body: some View {
        NavigationView {
            List {
                ForEach(GeoDatabase.shared.booksForParentId(bookId ?? 1)) { book in
                    NavigationLink(book.citeFull, destination:
                                    ChapterBrowser(bookId: book.id))
                }
            }
            .navigationTitle(GeoDatabase.shared.bookForId(bookId ?? 1).citeFull)
        }
    }
}

struct ChapterBrowser: View {
    var bookId: Int?
    var body: some View {
        NavigationView {
            List {
                Text("Book Chapters: \(GeoDatabase.shared.bookForId(bookId ?? 1).numChapters ?? 1)")
                ForEach(1...10, id: \.self) { chapter in
                    NavigationLink("Chapter \(chapter)", destination:
                                    ChapterContentBrowser(viewModel: viewModel(bookId: bookId ?? 1, chapter: chapter)))
                }
            }
            .navigationTitle(GeoDatabase.shared.bookForId(bookId ?? 1).citeFull)
        }
    }
    
    private func viewModel(bookId: Int, chapter: Int) -> ViewModel {
        let viewModel = ViewModel()
        
        viewModel.navigateToChapter(bookId: bookId, chapter: chapter)
        
        return viewModel
    }
}
