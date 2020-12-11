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
    
    @State var isShowingPopover = false
    
    var body: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.geoPlaces) { geoPlace in
                MapAnnotation(coordinate: CLLocationCoordinate2D(
                                latitude: geoPlace.latitude,
                                longitude: geoPlace.longitude),
                              anchorPoint: CGPoint(x:0.5, y:0.5)) {
                    VStack {
                        Image(systemName: "mappin")
                            .font(.system(size: 30))
                            .foregroundColor(Color(red: 0.75, green: 0.1, blue:0.1))
                            .shadow(radius: 1, x: 1, y: 1)
                            .popover(isPresented: $isShowingPopover, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
                                VStack {
                                    Text(GeoDatabase.shared.geoPlaceForId(viewModel.locationIdForPopover)?.placename ?? "")
                                    createImage(imageId: viewModel.locationIdForPopover)
                                        .resizable()
                                        .scaledToFit()
                                }
                                .frame(width: 400, height: 400)
                                .onTapGesture {
                                    if viewModel.isDetailVisable == false {
                                        isShowingPopover = false
                                    }
                                }
                            }
                            .onTapGesture {
                                viewModel.locationIdForPopover = geoPlace.id
                                isShowingPopover = true
                            }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                let map = MKMapView.appearance()
                
                map.mapType = .satellite
                map.showsScale = true
            }
    }
    
    // Creates images to be displayed in popover. If no image for an id it will create a generic "No image" image
    private func createImage(imageId: Int) -> Image {
        let uiImage =  (UIImage(named: String(imageId)) ?? UIImage(named: "0"))!
           return Image(uiImage: uiImage)
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

