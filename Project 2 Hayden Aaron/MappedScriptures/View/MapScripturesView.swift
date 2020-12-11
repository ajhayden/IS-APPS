//
//  ContentView.swift
//  MappedScriptures
//
//  Created by Student on 11/17/20.
//

import SwiftUI

// MapScripture view contains the volume browser and the intial map view
struct MapScripturesView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VolumeBrowser(viewModel: viewModel)
            PrimaryMapView(viewModel: viewModel)
                .navigationBarTitle(viewModel.currentLocation,
                    displayMode: .inline)
        }
    }
}

struct VolumeBrowser: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
            List {
                ForEach(GeoDatabase.shared.volumes()) { volume in
                    NavigationLink(volume.citeFull, destination:
                                    BookListBrowser(viewModel: viewModel, volumeId: volume.id))
                        .isDetailLink(false)
                }
            }
            .navigationTitle("Standard Works")
    }
}

struct BookListBrowser: View {
    @ObservedObject var viewModel: ViewModel
    
    var volumeId: Int
    
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
            viewModel.currentLocation = GeoDatabase.shared.bookForId(viewModel.volumeId).citeFull
        }
    }
}

struct ChapterListBrowser: View {
    @ObservedObject var viewModel: ViewModel
    
    var bookId: Int
    
    var body: some View {
        List {
            // I handle situations where the number of chapters does not match the traditional chaper list (+1 chapters)
            if viewModel.numChapters != 0 {
                ForEach(1...viewModel.numChapters, id: \.self) { chapter in
                    NavigationLink("Chapter \(chapter)", destination:
                                    ChapterContentBrowser(viewModel: viewModel, chapter: chapter))
                        .isDetailLink(false)
                }
            } else {
                ForEach(0...viewModel.numChapters, id: \.self) { chapter in
                    NavigationLink(GeoDatabase.shared.bookForId(viewModel.bookId).citeFull, destination:
                                    ChapterContentBrowser(viewModel: viewModel, chapter: chapter))
                        .isDetailLink(false)
                }
            }
            
        }
        .navigationTitle(GeoDatabase.shared.bookForId(viewModel.bookId).citeFull)
        .onAppear {
            viewModel.bookId = bookId
            viewModel.currentLocation = GeoDatabase.shared.bookForId(viewModel.bookId).citeFull
        }
    }
}

struct PrimaryMapView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            MapView(viewModel: viewModel)
                .onAppear {
                    viewModel.isDetailVisable = geometry.frame(in: .global).maxY > 0
                }
        }
    }
}




