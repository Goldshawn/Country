//
//  InformationManagerTests.swift
//  CountryTests
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import XCTest
@testable import Country

class InformationManagerTests: XCTestCase {

    var sut: InformationViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchWithPlanetExtension (){
        let mockNetwork = MockNetworkService()
        sut = InformationViewModel(mockNetwork, MockPersistenceManager())
        
        sut.fetch(with: .all)
        
        XCTAssertTrue(mockNetwork.isGetCountryInformationCalled)
    }
    
    func testLoadFromMemoryWithStarshipExtension (){
        let persistData = MockPersistenceManager()
        sut = InformationViewModel(MockNetworkService(), persistData)
        
        sut.loadFromMemory(with: .all)
        
        XCTAssertTrue(persistData.wasLoadDataCalled)
    }

}
