//
//  MockApiRequest.swift
//  TechTask
//
//  Created by kevin.fugaban on 8/30/22.
//

import Foundation
@testable import TechTask

final class MockApiRequest: AirportApiProtocol, Mockable {
    func fetch<T: Codable>(url: URL) async throws -> [T] {
        return loadJson(filename: "AirportResponseJson", type: T.self)
    }

}
