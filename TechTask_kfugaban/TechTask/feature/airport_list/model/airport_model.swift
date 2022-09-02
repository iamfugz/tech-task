//
//  airport_model.swift
//  TechTask
//
//  Created by kevin.fugaban on 8/26/22.
//

import Foundation

struct Airport: Codable {
    let airportCode: String
    let internationalAirport: Bool
    let domesticAirport: Bool
    let regionalAirport: Bool
    let onlineIndicator: Bool
    let eticketableAirport: Bool
    let location: Location
    let airportName: String
    let city: City
//    let state: State
    let country: Country
//    let region: Region
}

struct Location: Codable {
    let aboveSeaLevel: Int?
    let latitude: Double?
    let latitudeRadius: Double?
    let longitude: Double?
    let longitudeRadius: Double?
    let latitudeDirection: String?
    let longitudeDirection: String?
}
//
struct City: Codable {
    let cityCode: String?
    let cityName: String?
    let timeZoneName: String?
}
//
//struct State: Codable {
//    let stateCode: String
//    let stateName: String
//}
//
struct Country: Codable {
    let countryCode: String
    let countryName: String
}
//
//struct Region: Codable {
//    let regionCode: String
//    let regionName: String
//}
