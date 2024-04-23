//
//  FirebaseDataParser.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/22/23.
//

import Foundation

// MARK: - protocol
protocol FirebaseParser {
    associatedtype T: Codable
    func parseData(data: Any, callback: @escaping ((Result<T, Error>) -> Void))
    func parseOnEndedStatus(data: Any, callback: @escaping (Result<T, Error>) -> Void)
    func parseDictionary(dictionary: Any, callback: @escaping (Result<T, Error>) -> Void)
    func parseError(for dictionary: Dictionary<String, Any>, callback: @escaping (Result<T, Error>) -> Void)
}

// MARK: - default behaviour
extension FirebaseParser {
    func parseData(data: Any, callback: @escaping ((Result<T, Error>) -> Void)) {
        Logger.log(.info, data)
        guard let dictionary = data as? Dictionary<String, Any>,
              let responseModel = DictionaryMapper.decodeDictionaryToModel(dictionary, type: ResponseModel.self),
              let status = responseModel.status
        else {
            Logger.log(.error, "there is no status")
            return
        }
        
        switch status {
        case .ended:
            if let responseData = dictionary["responseData"] {
                self.parseOnEndedStatus(data: responseData, callback: callback)
            } else {
                self.parseOnEndedStatus(data: dictionary, callback: callback)
            }
            return
        case .error:
            parseError(for: dictionary, callback: callback)
        case .pending: return
        }
    }

    func parseError(for dictionary: Dictionary<String, Any>, callback: @escaping (Result<T, Error>) -> Void) {
        var message = "Something went wrong"
        if let code = dictionary["errorCode"] as? Int{
            switch code {
            case 500: message = "Internal Error"
            default: break
            }
        }
        callback(.failure(CustomError(description: message)))
        return
    }
    
    func parseOnEndedStatus(data: Any, callback: @escaping (Result<T, Error>) -> Void) {
        var dictionary = data as? Dictionary<String, Any>
        
        if let stringJson = data as? String {
            dictionary = stringJson.toJson()
        }
        
        guard let dictionary = dictionary else {
            Logger.log(.error, "decoding failed: No Json", data)
            callback(.failure(CustomError(description: "decoding failed: No Json")))
            return }
        parseDictionary(dictionary: dictionary, callback: callback)
    }
    
    func parseDictionary(dictionary: Any, callback: @escaping (Result<T, Error>) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let decoder = JSONDecoder()
            let decodedModel = try decoder.decode(T.self, from: jsonData)
            callback(.success(decodedModel))
        } catch {
            Logger.log(.error, "decoding failed: No Json", dictionary)
            callback(.failure(CustomError(description: "Error decoding: \(error.localizedDescription)")))
        }
    }
}
