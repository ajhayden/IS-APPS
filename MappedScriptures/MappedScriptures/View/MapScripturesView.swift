//
//  ContentView.swift
//  MappedScriptures
//
//  Created by Student on 11/17/20.
//

import SwiftUI

struct MapScripturesView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VolumeBrowser(viewModel: viewModel)
            PrimaryDetailMapView(viewModel: viewModel)
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
        }
    }
}

struct PrimaryDetailMapView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            DetailMapView(viewModel: viewModel)
                .onAppear {
                    viewModel.isDetailVisable = geometry.frame(in: .global).maxY > 0
                }
        }
    }
}

struct DetailMapView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        MapView(viewModel: viewModel)
    }
}

//min plus max / 2 is the half way point

// NEED TO:
// Figure out how to use 1 instead of 0
// Create a central point that is computed for each chapter
    // This is working but not for tablet
// Zoom to a location when click on hyper link in scripture
    // Not working for tablet
// Popup with name when you click pin
    // On tap gesture does not seem to be working
// Zoom to see all points on the map
