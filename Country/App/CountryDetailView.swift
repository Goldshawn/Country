//
//  CountryDetailView.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 08/11/2022.
//

import SwiftUI

struct CountryDetailView: View {
    // MARK: - PROPERTIES
    
    let country: CountryElement?

    // MARK: - BODY
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .center, spacing: 20) {

            // TITLE
              Text(country?.name?.common?.uppercased() ?? "")
              .font(.largeTitle)
              .fontWeight(.heavy)
              .multilineTextAlignment(.center)
              .padding(.vertical, 8)
              .foregroundColor(.primary)
              .background(
                Color.accentColor
                  .frame(height: 6)
                  .offset(y: 24)
              )
            
            // DESCRIPTION
            Group {
                GroupBox(
                  label:
                    HeadingView(headingImage: "info.circle", headingText: "All about \(country?.name?.common ?? "")")
                ) {
                    InfoRowView(name: "Official Name", content: country?.name?.official)
                    
                    let currencySorted = country?.currencies?.sorted(by: { $0.key < $1.key })
                    
                    ForEach(currencySorted!, id: \.key) { (name, currency) in
                        InfoRowView(name: "Currency Name", content: currency.name)
                        
                        InfoRowView(name: "Currency Symbol", content: currency.symbol)
                    }
                    
                    let languageSorted = country?.languages?.sorted(by: { $0.key < $1.key })
                    
                    
                    ForEach(languageSorted!, id: \.key) { (name, language) in
                        InfoRowView(name: "Language", content: language)
                    }
                    
                    InfoRowView(name: "Capital City", content: country?.capital?.joined(separator: ","))
                    InfoRowView(name: "Region", content: country?.region?.rawValue)
                    InfoRowView(name: "Sub-Region", content: country?.subregion)
                    InfoRowView(name: "Area", content: "\(country?.area ?? 0.00) kmsq")
                    InfoRowView(name: "Population", content: "\(country?.population ?? 10) People")
                    InfoRowView(name: "Independent?", content: country?.independent ?? false ? "Yes" : "No")
                }
            }
            .padding(.horizontal)

            // MAP
            Group {
              HeadingView(headingImage: "map", headingText: "Capital Location")

                InsetMapView(country: country)
            }
            .padding(.horizontal)
            
            // LINK
            Group {
              HeadingView(headingImage: "map.circle.fill", headingText: "View Location")
              
              ExternalWebLinkView(country: country)
            }
            .padding(.horizontal)
          } //: VSTACK
          .navigationBarTitle("Learn about \(country?.name?.common ?? "")", displayMode: .inline)
        } //: SCROLL
      }
}

// MARK: - PREVIEW

struct CountryDetailView_Previews: PreviewProvider {
    static let countries: Country? = {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let networkData = NetworkService(withMethod: .get, withURLExtension: .all, session: session)
        let countryViewModel = InformationViewModel(networkData, PersistenceManager())
        
        countryViewModel.loadFromMemory(with: .all)
        return countryViewModel.countries
    }()
    
    static var previews: some View {
        CountryDetailView(country: (countries?[0]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
