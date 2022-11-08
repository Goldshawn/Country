//
//  MockURLSession.swift
//  CountryTests
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation
@testable import Country

class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    var nextResponse: URLResponse?
    
    private (set) var lastURL: URL?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, nextResponse, nextError)
        return nextDataTask
    }

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
