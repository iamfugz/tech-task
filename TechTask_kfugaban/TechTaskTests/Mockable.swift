//
//  Mockable.swift
//  TechTaskTests
//
//  Created by kevin.fugaban on 8/30/22.
//

import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJson<T: Decodable>(filename: String, type: T.Type) -> [T]
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJson<T: Decodable>(filename: String, type: T.Type) -> [T] {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load json file.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode([T].self , from: data)
            
            return decodedObject
        } catch {
            fatalError("Failed to load json file.")
        }
    }
}
