//
//  CONSTANTS.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation

// MARK: Constants
struct Constants {
    static private let BASE_URL = "https://restcountries.com/v3.1/"
    
    // computed fullURL
    static func fullURL(with urlExtension: URLExtensions) -> String {
        return Constants.BASE_URL + urlExtension.rawValue
    }
}

// MARK: URLExtensions
// created this first. turned out to be the major switcher on the app.
enum URLExtensions: String {
    case all
}
