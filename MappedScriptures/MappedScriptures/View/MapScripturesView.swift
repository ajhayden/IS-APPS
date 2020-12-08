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
                        .isDetailLink(false)
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
    var volumeId: Int
    
    // Write a decion for more than one chapter
    
    var body: some View {
        List {
            ForEach(GeoDatabase.shared.booksForParentId(viewModel.volumeId)) { book in
                NavigationLink(book.citeFull, destination:
                                ChapterListBrowser(viewModel: viewModel, bookId: book.id))
                    .isDetailLink(false)
                
            }
        }
        .navigationTitle(GeoDatabase.shared.bookForId(viewModel.volumeId).citeFull)
        .onAppear {
            viewModel.volumeId = volumeId
        }
    }
}

struct ChapterListBrowser: View {
    @ObservedObject var viewModel: ViewModel
    var bookId: Int
    
    var body: some View {
        List {
            ForEach(0...viewModel.numChapters, id: \.self) { chapter in
                NavigationLink("Chapter \(chapter)", destination:
                                ChapterContentBrowser(viewModel: viewModel, chapter: chapter))
                    .isDetailLink(false)
            }
        }
        .navigationTitle(GeoDatabase.shared.bookForId(viewModel.bookId).citeFull)
        .onAppear {
            viewModel.bookId = bookId
        }
    }
}


// NEED TO:
// Figure out how to use 1 instead of 0
// Create a central point that is computed for each chapter
    // This is working but not for tablet
// Escape modal view when needed
// Popup with name when you click on the hyper linked location
