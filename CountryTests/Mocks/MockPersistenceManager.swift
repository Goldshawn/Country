//
//  MockPersistenceManager.swift
//  CountryTests
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation
@testable import Country

final class MockPersistenceManager: FileManagerServiceProtocol {
    
    var wasPersistDataCalled = false
    func persistData(dataToSave: Data, path: URLExtensions) {
        wasPersistDataCalled = true
    }
    
    var dataToReturn: Data?
    var wasLoadDataCalled = false
    
    func loadPersistedData(path: URLExtensions) -> Data? {
        wasLoadDataCalled = true
        return dataToReturn
    }
}

