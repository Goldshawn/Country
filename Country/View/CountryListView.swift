//
//  CountryListView.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import SwiftUI

struct CountryListView: View {
    // MARK: PROPERTIES
    
    let country: CountryElement?
    
    // MARK: BODY
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text(country?.flag ?? "")
                .foregroundColor(Color("ColorRed"))
            
            Text(country?.name?.common ?? "Nigeria")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color("ColorBlue"))
        }//: HSTACK
    }
}
// MARK: PREVIEW
struct CountryListView_Previews: PreviewProvider {
    static let countries: Country? = {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let networkData = NetworkService(withMethod: .get, withURLExtension: .all, session: session)
        let countryViewModel = InformationViewModel(networkData, PersistenceManager())
        
        countryViewModel.loadFromMemory(with: .all)
        return countryViewModel.countries
    }()
    
    static var previews: some View {
        CountryListView(country: (countries?[0]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
