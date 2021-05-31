//
//  Codable+Helpers.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        let serialized = (try? JSONSerialization.jsonObject(with: self.encode(), options: .allowFragments)) ?? nil
        return serialized as? [String: Any] ?? [String: Any]()
    }
    
    func encode() -> Data {
        return (try? JSONEncoder().encode(self)) ?? Data()
    }
}

extension Data {
    func decode<T: Decodable>(_ object: T.Type) -> T? {
        do {
            return (try JSONDecoder().decode(T.self, from: self))
        } catch {
            LoggersManager.error("Failed to Parse Object with this type: \(object)\nError: \(error)")
            return nil
        }
    }
}
