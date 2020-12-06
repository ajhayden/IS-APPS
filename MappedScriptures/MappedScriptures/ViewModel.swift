//
//  ViewModel.swift
//  MappedScriptures
//
//  Created by Student on 12/5/20.
//

import Foundation

class ViewModel: ObservableObject, GeoPlaceCollector {
    
    @Published var bookId = 0
    @Published var chapter = 0
    @Published var geoPlaces = [GeoPlace]()
    @Published var html = ""
   
    // MARK: - Initialization
    
    init() {
        ScriptureRenderer.shared.injectGeoPlaceCollector(self)
    }
    
    // MARK: - Intents
    
    func navigateToChapter(bookId: Int, chapter: Int) {
        self.bookId = bookId
        self.chapter = chapter
        
        html = ScriptureRenderer.shared.htmlForBookId(bookId, chapter: chapter)
    }
    
    // MARK: - GeoPlaceCollector
    
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        if let places = places {
            geoPlaces = places
            
            // NEEDS WORK: Process this and remove any duplicates
            geoPlaces.forEach() { place in
                print(place.placename)
            }
        }
    }
    
    
}
