//
//  MapView.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 08/11/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    // MARK: - PROPERTIES
    
    @State private var region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    // MARK: - PROPERTIES
    
    let country: CountryElement?
    
    // MARK: - BODY
    
    var body: some View {
        // MARK: - No1 BASIC MAP
        Map(coordinateRegion: $region)//: MAP
        .overlay(
            HStack(alignment: .center, spacing: 12) {
                Image("compass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48, alignment: .center)
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text("Latitude:")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.latitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Longitude:")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.longitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }
            } //: HSTACK
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    Color.black
                        .cornerRadius(8)
                        .opacity(0.6)
                )
                .padding()
            , alignment: .top
        )
        .onAppear {
            self.region = MKCoordinateRegion(center: (country?.capitalInfo!.location)!, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
    
    // MARK: - PREVIEW

    struct MapView_Previews: PreviewProvider {
        static let countries: Country? = {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let networkData = NetworkService(withMethod: .get, withURLExtension: .all, session: session)
            let countryViewModel = InformationViewModel(networkData, PersistenceManager())
            
            countryViewModel.loadFromMemory(with: .all)
            return countryViewModel.countries
        }()
        
        static var previews: some View {
            MapView(country: (countries?[0]))
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
