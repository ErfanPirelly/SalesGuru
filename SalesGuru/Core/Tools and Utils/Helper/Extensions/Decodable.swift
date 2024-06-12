//
//  Decodable.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/19/23.
//

import Foundation


struct DictionaryMapper {
    static func decodeDictionaryToModel<T: Decodable>(_ dictionary: [String: Any], type: T.Type) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            print("Serialized JSON Data: \(String(data: jsonData, encoding: .utf8) ?? "")")
            let decoder = JSONDecoder()
            let decodedModel = try decoder.decode(type, from: jsonData)
            return decodedModel
        } catch {
            print("Error decoding: \(error)")
            return nil
        }
    }
}

extension Dictionary {
    func decode<T: Decodable>() -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

extension String {
    func toJson() -> [String: Any]? {
        if let jsonData = self.data(using: .utf8) {
            let responseData = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
            return responseData
        } else {
            return nil
        }
    }
}
