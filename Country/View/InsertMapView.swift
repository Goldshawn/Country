//
//  InsertMapView.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 08/11/2022.
//

import SwiftUI
import MapKit

struct InsetMapView: View {
    // MARK: - PROPERTIES
    
    let country: CountryElement?
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    // MARK: - BODY
    
    var body: some View {
        Map(coordinateRegion: $region)
            .overlay(
                NavigationLink(destination: MapView(country: country)) {
                    HStack {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(Color.white)
                            .imageScale(.large)
                        
                        Text("Locations")
                            .foregroundColor(.accentColor)
                            .fontWeight(.bold)
                    } //: HSTACK
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(
                        Color.black
                            .opacity(0.4)
                            .cornerRadius(8)
                    )
                } //: NAVIGATION
                    .padding(12)
                , alignment: .topTrailing
            )
            .frame(height: 256)
            .cornerRadius(12)
            .onAppear {
                self.region = MKCoordinateRegion(center: (country?.capitalInfo!.location)!, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            }
    }
}

// MARK: - PREVIEW

struct InsetMapView_Previews: PreviewProvider {
    static let countries: Country? = {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let networkData = NetworkService(withMethod: .get, withURLExtension: .all, session: session)
        let countryViewModel = InformationViewModel(networkData, PersistenceManager())
        
        countryViewModel.loadFromMemory(with: .all)
        return countryViewModel.countries
    }()
    
    static var previews: some View {
        InsetMapView(country: (countries?[0]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
