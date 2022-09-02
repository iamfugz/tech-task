//
//  AirportApiRequests.swift
//  TechTask
//
//  Created by kevin.fugaban on 8/26/22.
//

import Foundation

enum ApiError: Error {
    case badResponse, errorDecodingData
}

protocol AirportApiProtocol {
    func fetch<T: Codable>(url: URL) async throws -> [T]
}

class AirportApiRequest: AirportApiProtocol {
    
    func fetch<T: Codable>(url: URL) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw ApiError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else {
            throw ApiError.errorDecodingData
        }
        
        return object
    }
}
