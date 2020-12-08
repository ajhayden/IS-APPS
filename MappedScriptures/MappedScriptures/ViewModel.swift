//
//  ViewModel.swift
//  MappedScriptures
//
//  Created by Student on 12/5/20.
//

import Foundation

class ViewModel: ObservableObject, GeoPlaceCollector {
    
    @Published var volumeId = 0
    @Published var bookId = 0 {
        didSet {
            numChapters = GeoDatabase.shared.bookForId(bookId).numChapters ?? 0
        }
    }
    @Published var chapter = 0 {
        didSet {
            html = ScriptureRenderer.shared.htmlForBookId(bookId, chapter: chapter)
        }
    }
    @Published var geoPlaces = [GeoPlace]()
    @Published var html = ""
    @Published var numChapters = 0
    
   
    // MARK: - Initialization
    
    init() {
        ScriptureRenderer.shared.injectGeoPlaceCollector(self)
    }
    
    // MARK: - Intents
    
    func navigateToChapter(bookId: Int, chapter: Int) {
        self.bookId = bookId
        self.chapter = chapter
    }
    
    func navigateToChapter(chapter: Int) {
        self.chapter = chapter
    }
    
    // MARK: - GeoPlaceCollector
    
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        if let places = places {
            geoPlaces = places
            
//            for place in geoPlaces {
//
//            }
            
            // NEEDS WORK: Process this and remove any duplicates
            geoPlaces.forEach() { place in
                print(place.placename)
            }
        }
    }

}

