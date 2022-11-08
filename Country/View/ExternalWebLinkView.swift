//
//  ExternalWebLinkView.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 08/11/2022.
//

import SwiftUI

struct ExternalWebLinkView: View {
    // MARK: - PROPERTIES
    
    let country: CountryElement?
    
    // MARK: - BODY

    fileprivate func quickLink(_ name: String, _ url: String) -> HStack<TupleView<(Image, Text, Spacer, some View)>> {
        return HStack {
            Image(systemName: "map")
            Text(name)
            Spacer()
            
            Group {
                Image(systemName: "arrow.up.right.square")
                
                Link(country?.name?.common ?? "google", destination: (URL(string: url) ?? URL(string: "https://maps.google.com"))!)
            }
            .foregroundColor(.accentColor)
        }//: HSTACK
    }
    
    var body: some View {
      GroupBox {
          quickLink("Google Map", country?.maps?.googleMaps ?? "")
              .padding(.bottom)
          quickLink("Open Street Map", country?.maps?.openStreetMaps ?? "")
      } //: BOX
    } //: BODY
}

// MARK: - PREIVEW

struct ExternalWebLinkView_Previews: PreviewProvider {
    static let countries: Country? = {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let networkData = NetworkService(withMethod: .get, withURLExtension: .all, session: session)
        let countryViewModel = InformationViewModel(networkData, PersistenceManager())
        
        countryViewModel.loadFromMemory(with: .all)
        return countryViewModel.countries
    }()
    
    static var previews: some View {
        ExternalWebLinkView(country: (countries?[0]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
