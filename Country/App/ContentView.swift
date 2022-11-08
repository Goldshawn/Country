//
//  ContentView.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import SwiftUI

struct ContentView: View {
    //MARK: PROPERTIES
    
    @ObservedObject var viewModel: InformationViewModel
    
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            if viewModel._isLoading && viewModel.countries?.count ?? 0 > 0{
                ProgressView()
            }else {
                List {
                    ForEach(viewModel.countries ?? [], id: \.self){ country in
                        NavigationLink(destination: CountryDetailView(country: country)) {
                            CountryListView(country: country)
                                .padding()
                        }//: LINK
                    }//: LOOP
                }//: LIST
                .background(
                    MotionAnimationView().ignoresSafeArea()
                )
                .scrollContentBackground(.hidden)
                .navigationBarTitle("Countries")
                
            }
        }//: NAVIGATION
        .navigationViewStyle(.stack)
        .onAppear {
            viewModel.loadFromMemory(with: .all)
            hapticImpact.impactOccurred()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let viewModel: InformationViewModel = {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let networkData = NetworkService(withMethod: .get, withURLExtension: .all, session: session)
        return InformationViewModel(networkData, PersistenceManager())
    }()
    
    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
