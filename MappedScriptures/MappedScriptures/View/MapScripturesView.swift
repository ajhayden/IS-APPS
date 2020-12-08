//
//  ContentView.swift
//  MappedScriptures
//
//  Created by Student on 11/17/20.
//

import SwiftUI

struct VolumeBrowser: View {
    
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(GeoDatabase.shared.volumes()) { volume in
                    NavigationLink(volume.citeFull, destination:
                                    BookListBrowser(viewModel: viewModel, volumeId: volume.id))
                }
            }
            .navigationTitle("Standard Works")
            
            MapView(viewModel: viewModel)
        }
    }
}

struct VolumeBrowser_Previews: PreviewProvider {
    static var previews: some View {
        VolumeBrowser()
    }
}

struct BookListBrowser: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel, volumeId: Int) {
        self.viewModel = viewModel
        viewModel.volumeId = volumeId
    }
    
    // Write a decion for more than one chapter
    
    var body: some View {
        List {
            ForEach(GeoDatabase.shared.booksForParentId(viewModel.bookId)) { book in
                NavigationLink(book.citeFull, destination:
                                ChapterListBrowser(viewModel: viewModel, bookId: book.id))
            }
        }
        .navigationTitle(GeoDatabase.shared.bookForId(viewModel.bookId).citeFull)
    }
}

struct ChapterListBrowser: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel, bookId: Int) {
        self.viewModel = viewModel
        viewModel.bookId = bookId
    }
    
    var body: some View {
        List {
            ForEach(1...viewModel.numChapters, id: \.self) { chapter in
                NavigationLink("Chapter \(chapter)", destination:
                                ChapterContentBrowser(viewModel: viewModel, chapter: chapter))
            }
        }
        .navigationTitle(GeoDatabase.shared.bookForId(viewModel.bookId).citeFull)

    }
}
