//
//  NetworkServiceProtocol.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation

///This protocal helps facilitate network operationsi.e. API and web services
protocol NetworkServiceProtocol {
    
    ///This function is called to get countryDetails, returns the approprait detail in response or Network Error
    func getcountriesInformation(completion: @escaping((Result<Country, NetworkError>) -> Void))
}
