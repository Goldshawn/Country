//
//  NetworkConectionTests.swift
//  CountryTests
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import XCTest
@testable import Country

class NetworkConectionTests: XCTestCase {
    var sut: NetworkService!
    var session = MockURLSession()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = NetworkService(withMethod: .get, withURLExtension: .all, session: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func test_get_resume_called() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        sut.getcountriesInformation{ someResponse in
            //Return Data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data_for_planet() {
        let expectedData = "[{\"name\":{\"common\":\"Barbados\",\"official\":\"Barbados\",\"nativeName\":{\"eng\":{\"official\":\"Barbados\",\"common\":\"Barbados\"}}},\"tld\":[\".bb\"],\"cca2\":\"BB\",\"ccn3\":\"052\",\"cca3\":\"BRB\",\"cioc\":\"BAR\",\"independent\":true,\"status\":\"officially-assigned\",\"unMember\":true,\"currencies\":{\"BBD\":{\"name\":\"Barbadiandollar\",\"symbol\":\"$\"}},\"idd\":{\"root\":\"+1\",\"suffixes\":[\"246\"]},\"capital\":[\"Bridgetown\"],\"altSpellings\":[\"BB\"],\"region\":\"Americas\",\"subregion\":\"Caribbean\",\"languages\":{\"eng\":\"English\"},\"translations\":{\"ara\":{\"official\":\"باربادوس\",\"common\":\"باربادوس\"},\"bre\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"ces\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"cym\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"deu\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"est\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"fin\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"fra\":{\"official\":\"Barbade\",\"common\":\"Barbade\"},\"hrv\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"hun\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"ita\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"jpn\":{\"official\":\"バルバドス\",\"common\":\"バルバドス\"},\"kor\":{\"official\":\"바베이도스\",\"common\":\"바베이도스\"},\"nld\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"per\":{\"official\":\"باربادوس\",\"common\":\"باربادوس\"},\"pol\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"por\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"rus\":{\"official\":\"Барбадос\",\"common\":\"Барбадос\"},\"slk\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"spa\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"swe\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"tur\":{\"official\":\"Barbados\",\"common\":\"Barbados\"},\"urd\":{\"official\":\"بارباڈوس\",\"common\":\"بارباڈوس\"},\"zho\":{\"official\":\"巴巴多斯\",\"common\":\"巴巴多斯\"}},\"latlng\":[13.16666666,-59.53333333],\"landlocked\":false,\"area\":430.0,\"demonyms\":{\"eng\":{\"f\":\"Barbadian\",\"m\":\"Barbadian\"},\"fra\":{\"f\":\"Barbadienne\",\"m\":\"Barbadien\"}},\"flag\":\"\\uD83C\\uDDE7\\uD83C\\uDDE7\",\"maps\":{\"googleMaps\":\"https://goo.gl/maps/2m36v8STvbGAWd9c7\",\"openStreetMaps\":\"https://www.openstreetmap.org/relation/547511\"},\"population\":287371,\"fifa\":\"BRB\",\"car\":{\"signs\":[\"BDS\"],\"side\":\"left\"},\"timezones\":[\"UTC-04:00\"],\"continents\":[\"NorthAmerica\"],\"flags\":{\"png\":\"https://flagcdn.com/w320/bb.png\",\"svg\":\"https://flagcdn.com/bb.svg\"},\"coatOfArms\":{\"png\":\"https://mainfacts.com/media/images/coats_of_arms/bb.png\",\"svg\":\"https://mainfacts.com/media/images/coats_of_arms/bb.svg\"},\"startOfWeek\":\"monday\",\"capitalInfo\":{\"latlng\":[13.1,-59.62]},\"postalCode\":{\"format\":\"BB#####\",\"regex\":\"^(?:BB)*(\\\\d{5})$\"}}]".data(using: .utf8)
        
        
        session.nextData = expectedData
        
        var actualData: Country?
        var actualError: Error?
        let dataExpectation = expectation(description: "data")
        sut.getcountriesInformation { data in
            print(data, "holding")
            switch data {
            case .success(let dataInfo):
                actualData = dataInfo
            case .failure(let errors):
                actualError = errors
            }
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertNil(actualError)
            XCTAssertNotNil(actualData)
        }
    }
    
    func test_get_should_return_with_error() {
        let expectedError = NSError(domain: "error", code: 1234, userInfo: nil)
        session.nextError = expectedError
        
        var actualError: Error?
        var actualData: Country?
        let errorExpectation = expectation(description: "error")
        sut.getcountriesInformation { data in
            switch data{
            case .success(let dataInfo):
                actualData = dataInfo
            case .failure(let errors):
                actualError = errors
            }
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNil(actualData)
            XCTAssertNotNil(actualError)
        }
    }
}

