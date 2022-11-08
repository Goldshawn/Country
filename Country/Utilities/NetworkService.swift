//
//  NetworkService.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation
import Combine
import OSLog

///This implements the network communication operations
class NetworkService: NetworkServiceProtocol {
    private var fullURL: String
    private var method: Method
    private var urlExtension: URLExtensions
    private let session: URLSessionProtocol
    
    init(withMethod method: Method, withURLExtension urlExtension: URLExtensions, session: URLSessionProtocol) {
        self.fullURL = Constants.fullURL(with: urlExtension)
        self.method = method
        self.session = session
        self.urlExtension = urlExtension
    }
    
    ///This function is called to get countryDetails, returns the approprait detail in response or Network Error
    func getcountriesInformation(completion: @escaping ((Result<Country, NetworkError>) -> Void)) {
        request(method: method, completion: completion)
    }
    
    /// this is the private function that would create the URLRequest. Basically manages the header and body of the api call
    private func request<T: Codable>(method: Method,
                                  completion: @escaping((Result<[T], NetworkError>) -> Void)) {
        //ensure a valid url is formed
        guard let urlString = URL(string: fullURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        
        var request = URLRequest(url: urlString)
        request.httpMethod = method.rawValue.uppercased()
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        call(with: request, completion: completion)
    }
    /// this is the private function that would calles the API endpoint. The information is then encoded to be used later in the app
    private func call<T: Codable>(with request: URLRequest,
                                  completion: @escaping((Result<[T], NetworkError>) -> Void)) {
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                //return network failed error when network connection returns error
                os_log("failedRequest from server", log: OSLog.default, type: .error)
                completion(.failure(.failedRequest))
                return
            }
            
            guard let responseData = data else {
                //return empty respone error
                os_log("emptyResponse from server", log: OSLog.default, type: .error)
                completion(.failure(.emptyResponse))
                return
            }
            
            do {
                // this saves the data received to the path
                // can be updated to be done somewhere else.
                PersistenceManager().persistData(dataToSave: responseData, path: self.urlExtension)
                //tries to parse response
                print(responseData)
                let responseModel = try JSONDecoder().decode([T].self, from: responseData)
                os_log("Success from server", log: OSLog.default, type: .info)
                completion(.success(responseModel))
            } catch {
                //unable to parse response, return invalid response
                os_log("invalidResponse from server", log: OSLog.default, type: .error)
                completion(.failure(.invalidResponse))
            }
        }
        dataTask.resume()
    }
}

enum Method: String {
    case get
    case post
}

enum NetworkError: Error, Equatable {
    case invalidURL
    case emptyResponse
    case invalidResponse
    case failedRequest
    case responseInvalid
}
