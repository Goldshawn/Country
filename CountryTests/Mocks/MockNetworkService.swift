//
//  MockNetworkService.swift
//  CountryTests
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation
@testable import Country

///Mock network service for testing
class MockNetworkService: NetworkServiceProtocol {
    
    var isGetCountryInformationCalled: Bool = false
    var shouldGetCountryInformationReturnError: Bool = false
    var demoPlanetResponse: Country = []
    
    func getcountriesInformation(completion: @escaping ((Result<Country, NetworkError>) -> Void)) {
        isGetCountryInformationCalled = true
        
        guard !shouldGetCountryInformationReturnError else {
            completion(.failure(.failedRequest))
            return
        }
        
        completion(.success(self.demoPlanetResponse))
    }
}

