//
//  Map.swift
//  MappedScriptures
//
//  Created by Student on 12/5/20.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel: ViewModel
//    @State var isShowingPopover = false
    
    var body: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.geoPlaces) { geoPlace in
                MapAnnotation(coordinate: CLLocationCoordinate2D(
                                latitude: geoPlace.latitude,
                                longitude: geoPlace.longitude),
                              anchorPoint: CGPoint(x:0.5, y:0.5)) {
                    HStack {
                        Image(systemName: "mappin")
                            .font(.system(size: 30))
                            .foregroundColor(Color(red: 0.75, green: 0.1, blue:0.1))
                            .shadow(radius: 1, x: 1, y: 1)
//                        Text("Location")
                    }
                    .onTapGesture {
                        print("Selected: \(geoPlace.placename)")
                    }
//                        .popover(isPresented: $isShowingPopover) {
//                            Text("Hi from a popover")
//                                .padding()
//                                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                let map = MKMapView.appearance()
                
                map.mapType = .satellite
                map.showsScale = true
            }
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

