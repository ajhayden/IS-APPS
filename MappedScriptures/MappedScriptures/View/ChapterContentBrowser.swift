//
//  ChapterContentBrowser.swift
//  MappedScriptures
//
//  Created by Student on 12/5/20.
//

import SwiftUI

struct ChapterContentBrowser: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel, chapter: Int) {
        self.viewModel = viewModel
        viewModel.navigateToChapter(chapter: chapter)
    }
    
    var book: Book {
        GeoDatabase.shared.bookForId(viewModel.bookId)
    }
    
    var body: some View {
        VStack {
            WebView(html: viewModel.html, request: nil)
                .injectNavigationHandler { geoPlaceId in
                    print("User wants to highlight \(geoPlaceId)")
                    // NEEDS WORK: maybe goes to the ViewModel, viewModel to feed to map view some how
                }
                .navigationTitle(title())
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
