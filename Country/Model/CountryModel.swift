//
//  CountryModel.swift
//  Country
//
//  Created by Shalom (Xerxes) Owolabi on 07/11/2022.
//

import Foundation
import MapKit

// MARK: - CountryElement
struct CountryElement: Hashable, Codable {
    let name: Name?
    let tld: [String]?
    let cca2: String?
    let ccn3: String?
    let cca3: String?
    let cioc: String?
    let independent: Bool?
    let status: Status?
    let unMember: Bool?
    let currencies: [String: Currency]?
    let idd: Idd?
    let capital: [String]?
    let altSpellings: [String]?
    let region: Region?
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]?
    let latlng: [Double]?
    let landlocked: Bool?
    let area: Double?
    let demonyms: Demonyms?
    let flag: String?
    let maps: Maps?
    let population: Int?
    let fifa: String?
    let car: Car?
    let timezones: [String]?
    let continents: [Continent]?
    let flags, coatOfArms: CoatOfArms?
    let startOfWeek: StartOfWeek?
    let capitalInfo: CapitalInfo?
    let postalCode: PostalCode?
    let borders: [String]?
    let gini: [String: Double]?
}

// MARK: - CapitalInfo
struct CapitalInfo: Hashable, Codable {
    let latlng: [Double]?
    
    // Computed Property
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latlng?[0] ?? 0.00, longitude: latlng?[1] ?? 0.00)
    }
}

// MARK: - Car
struct Car: Hashable, Codable {
    let signs: [String]?
    let side: Side?
}

enum Side: String, Hashable, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Hashable, Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Currency
struct Currency: Hashable, Codable {
    let name: String?
    let symbol: String?
}

// MARK: - Demonyms
struct Demonyms: Hashable, Codable {
    let eng: Eng?
    let fra: Eng?
}

// MARK: - Eng
struct Eng: Hashable, Codable {
    let f, m: String?
}

// MARK: - Idd
struct Idd: Hashable, Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Hashable, Codable {
    let googleMaps, openStreetMaps: String?
}

// MARK: - Name
struct Name: Hashable, Codable {
    let common, official: String?
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Hashable, Codable {
    let official, common: String?
}

// MARK: - PostalCode
struct PostalCode: Hashable, Codable {
    let format: String?
    let regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}

typealias Country = [CountryElement]

