//
//  Map.swift
//  MappedScriptures
//
//  Created by Student on 12/5/20.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // NEEDS WORK: Compute what the points are for the map. Center should be the center of the rectangle that holds all of the pins
    // Maybe the whole thing can go into the viewModel
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 31.7683, longitude: 35.2137),
        span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
    )
    
    var body: some View {
        Map(coordinateRegion: $mapRegion,
            annotationItems: viewModel.geoPlaces) { geoPlace in
            MapAnnotation(coordinate: CLLocationCoordinate2D(
                            latitude: geoPlace.latitude,
                            longitude: geoPlace.longitude),
                          anchorPoint: CGPoint(x:0.5, y:0.5)) {
                Image(systemName: "mappin")
                    .font(.system(size: 30))
                    .foregroundColor(Color(red: 0.75, green: 0.1, blue:0.1))
                    .shadow(radius: 1, x: 1, y: 1)
                    .onTapGesture {
                        print("Selected \(geoPlace.placename)")
                        // When you tap one of these you could have a little pop up view that shows the name
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            let map = MKMapView.appearance()
            
            map.mapType = .satellite
            map.showsScale = true
        }
        .navigationBarTitle("Joshua 10")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: viewModel())
    }
    
    private static func viewModel() -> ViewModel {
        let viewModel = ViewModel()
        
        viewModel.navigateToChapter(bookId: 106, chapter: 10)
        
        return viewModel
    }
}
