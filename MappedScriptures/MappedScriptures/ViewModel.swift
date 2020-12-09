//
//  ViewModel.swift
//  MappedScriptures
//
//  Created by Student on 12/5/20.
//

import Foundation
import MapKit

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
    
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.7683, longitude: 35.2137), span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
    
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
            
            var minLatitude = 1000000000.0
            var maxLatitude = 0.0
            var minLongitude = 1000000000.0
            var maxLongitude = 0.0
            
            uniqueGeoPlaces.forEach() { place in
                print(place.placename)
                if place.latitude > maxLatitude {
                    maxLatitude = place.latitude
                }
                if place.latitude < minLatitude {
                    minLatitude = place.latitude
                }
                if place.longitude > maxLongitude {
                    maxLongitude = place.longitude
                }
                if place.longitude < minLongitude {
                    minLongitude = place.longitude
                }
            }
            print(maxLatitude)
            print(minLatitude)
            print(maxLongitude)
            print(minLongitude)
            
            if minLatitude == 1000000000.0 {
                self.mapRegion.center.latitude = 31.7683
                self.mapRegion.center.longitude = 35.2137
                self.mapRegion.span.latitudeDelta = 2
                self.mapRegion.span.longitudeDelta = 2
            } else {
                self.mapRegion.center.latitude = (maxLatitude + minLatitude) / 2
                self.mapRegion.center.longitude = (maxLongitude + minLongitude) / 2
                self.mapRegion.span.latitudeDelta = maxLatitude - minLatitude
                self.mapRegion.span.longitudeDelta = maxLongitude - minLongitude

            }
            
            geoPlaces = uniqueGeoPlaces
        }
    }

}

