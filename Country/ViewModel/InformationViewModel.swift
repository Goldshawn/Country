//
//  InformationViewModel.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import SwiftUI
import OSLog

/// ViewModel designed to work for the major api calles enabled by the server. It basically makes the api calls and publishes the useful information that can be used to populate views.
/// posible extensions would be to notify the rest of the app when waiting for response from the Network Service. Enabling the View to display a loading screen
class InformationViewModel: ObservableObject {
    
    @Published var countries: Country?
    @Published var _isLoading: Bool = true
    
    var networkData: NetworkServiceProtocol
    var persistData: FileManagerServiceProtocol
    
    // Injecting the NetworkServiceProtocol and FileManagerServiceProtocol
    init(_ networkData: NetworkServiceProtocol, _ persistData: FileManagerServiceProtocol) {
        self.networkData = networkData
        self.persistData = persistData
    }
    // the function fetches the contents with urlExtension. then passes said fetched value to the sortNetworkData Function
    // possible enhancement would be to simplify the calls
    func fetch(with urlExtention: URLExtensions) {
        switch urlExtention {
        case .all:
            networkData.getcountriesInformation { dataFromNetwork in
                self.sortNetworkData(dataFromNetwork, urlExtention: urlExtention)
            }
        }
    }
    // the function loads the information saved at the urlExtension provided. it then calls the fetch function
    func loadFromMemory(with urlExtention: URLExtensions){
        let memoryData = persistData.loadPersistedData(path: urlExtention)
        if let memoryData = memoryData {
            do {
                switch urlExtention {
                case .all:
                    let memoryDataDecoded = try JSONDecoder().decode(Country.self, from: memoryData)
                    self.countries = memoryDataDecoded
                }
            } catch let errors {
                print(errors)
                os_log("Failed to load information...", log: OSLog.default, type: .error)
            }
        }
        fetch(with: urlExtention)
    }
    
    // this is a file private function that collects the response from fatch then publishes it.
    fileprivate func sortNetworkData<T: Codable>(_ data: Result<T, NetworkError>, urlExtention: URLExtensions) {
        DispatchQueue.main.async {
            switch data {
            case .success(let dataInfo):
                switch urlExtention {
                case .all:
                    self.countries = dataInfo as? Country
                    self._isLoading = false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

