//
//  URLSessionProtocols.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
    
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        let task:URLSessionDataTask = dataTask(with: request, completionHandler: {
                                                (data:Data?, response:URLResponse?, error:Error?) in completionHandler(data,response,error) }) as URLSessionDataTask
        return task
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
