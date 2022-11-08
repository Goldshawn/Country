//
//  MainView.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import SwiftUI

struct MainView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    let allViewModel: InformationViewModel = {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let networkData = NetworkService(withMethod: .get, withURLExtension: .all, session: session)
        let tempViewModel = InformationViewModel(networkData, PersistenceManager())
        return tempViewModel
    }()
    
    var body: some View {
        VStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                ContentView(viewModel: allViewModel)
                .tabItem {
                    Image(systemName: "network")
                    Text("Country")
                }
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
