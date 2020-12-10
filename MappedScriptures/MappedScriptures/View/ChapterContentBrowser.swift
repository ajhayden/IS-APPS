//
//  ChapterContentBrowser.swift
//  MappedScriptures
//
//  Created by Student on 12/5/20.
//

import SwiftUI

struct ChapterContentBrowser: View {
    @ObservedObject var viewModel: ViewModel
    
    var chapter: Int
    
    @State private var displayModalDetailView = false
    
    var book: Book {
        GeoDatabase.shared.bookForId(viewModel.bookId)
    }
    
    var body: some View {
        VStack {
            WebView(html: viewModel.html, request: nil)
                .injectNavigationHandler { geoPlaceId in
                    print("User wants to highlight \(geoPlaceId)")
                    viewModel.mapRegion.center.latitude = GeoDatabase.shared.geoPlaceForId(geoPlaceId)?.latitude ?? 0.0
                    viewModel.mapRegion.center.longitude = GeoDatabase.shared.geoPlaceForId(geoPlaceId)?.longitude ?? 0.0
                    viewModel.mapRegion.span.latitudeDelta = 0.15
                    viewModel.mapRegion.span.longitudeDelta = 0.15
                    viewModel.currentLocation = GeoDatabase.shared.geoPlaceForId(geoPlaceId)?.placename ?? ""
                    
                    if !viewModel.isDetailVisable {
                        displayModalDetailView = true
                    }

                }
                .navigationBarItems(trailing: Group {
                    if !viewModel.isDetailVisable {
                        Button("Map") {
                            displayModalDetailView = true
                        }
                    }
                })
                .onAppear {
                    viewModel.chapter = chapter
                    viewModel.currentLocation = GeoDatabase.shared.bookForId(viewModel.bookId).citeFull + " \(chapter)"
                }
                .sheet(isPresented: $displayModalDetailView) {
                    NavigationView {
                        MapView(viewModel: viewModel)
                            .navigationBarTitle(viewModel.currentLocation.contains("0")
                                                    ? viewModel.currentLocation.replacingOccurrences(of: "0", with: "")
                                                    : viewModel.currentLocation,
                                                    displayMode: .inline)
                            .navigationBarItems(trailing: Button("Done", action: {
                                displayModalDetailView = false
                            }))
                    }
                }
        }
    }
    
    private func title() -> String {
        if viewModel.chapter > 0 {
            return "\(book.fullName) \(viewModel.chapter)"
        } else {
            return book.fullName
        }
    }
}

struct ChapterContentBrowser_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChapterContentBrowser(viewModel: viewModel(), chapter: 1)
        }
    }
    
    private static func viewModel() -> ViewModel {
        let viewModel = ViewModel()
        
        viewModel.navigateToChapter(bookId: 106, chapter: 10)
        
        return viewModel
    }
}
