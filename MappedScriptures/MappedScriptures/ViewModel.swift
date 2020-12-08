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
    
    static var latitude = 31.7683
    static var longitude = 35.2137
    
    var isDetailVisable = false
    
   
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
        var uniqueGeoPlaces = Array<GeoPlace>()
        if let places = places {
            geoPlaces = places
            
            for place in geoPlaces {
                if !uniqueGeoPlaces.contains(place) {
                    uniqueGeoPlaces.append(place)
                }
            }
            
            var counter = 0
            var latitudeSum = 0.0
            var longitudeSum = 0.0
            
            uniqueGeoPlaces.forEach() { place in
                counter += 1
                latitudeSum += place.latitude
                longitudeSum += place.longitude
            }
            
            ViewModel.latitude = latitudeSum / Double(counter)
            ViewModel.longitude = longitudeSum / Double(counter)
        }
    }

}

