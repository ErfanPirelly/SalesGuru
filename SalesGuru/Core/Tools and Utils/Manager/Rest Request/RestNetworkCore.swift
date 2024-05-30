//
//  RestNetworkCore.swift
//  Pirelly
//
//  Created by shndrs on 8/28/23.
//

import Foundation
import Alamofire

final class RestNetworkCore<T: Codable>: NSObject {
    internal static var userManager: UserManager {
        return inject()
    }
    
    private static var interceptor: Interceptor {
        return .init()
    }
    
    private static var sessionManager: Session {
        let temp = Alamofire.Session.default
        return temp
    }
    private static var isConnectedToTheInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

// MARK: - Methods

extension RestNetworkCore {
    // MARK: - Upload
    /// - Note: -  Use this when you wanna upload a file (such as picture or ...) to server
    
    static func upload(setup: RequestSetup,
                       data: Data,
                       callback: @escaping (_ response: T?, _ error: CustomError?) -> Void) {
        guard isConnectedToTheInternet else {
            let error = CustomError(description: "Device is not connected to the internet, Try again later!")
            callback(nil, error)
            return
        }
        let fileName = "bug-report-" + (userManager.uid ?? "uid-") + Date().description
        // Request
        
        let request = sessionManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: fileName)
        }, to: setup.route, method: setup.method, interceptor: interceptor)
        // Progress Percentage
        request.uploadProgress { progress in
            Logger.log(.info, progress.fractionCompleted)
        }
        // Response
        request.responseData { response in
            do {
                switch response.result {
                case .success(let value):
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: value)
                    callback(result, nil)
                case .failure:
                    callback(nil, convert(error: response.data))
                }
            } catch let error {
                let customError = CustomError(description: error.localizedDescription)
                callback(nil, customError)
                Logger.log(.error, customError)
            }
        }
    }
    
    // MARK: - Cancel all request in session
    static func cancelAllRequest() {
        Alamofire.Session.default.cancelAllRequests()
    }
    
    // MARK: - This method parse error response data to a CustomError object
    
    static func convert(error response: Data?) -> CustomError {
        guard let response = response else {
            return CustomError(description: "Unknown Error!")
        }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(RMError.self, from: response)
            let errorMessage: String = result.error ?? ""
            Logger.log(.error, errorMessage)
            return CustomError(description: errorMessage.trailingSpacesTrimmed)
        } catch let error {
            Logger.log(.error, error.localizedDescription)
                    return CustomError(description: "Unknown Error!")
        }
    }
}

// MARK: - use mapper
extension RestNetworkCore {
    static func fetch<T: RestDataParser>(_ dump: T, setup: RequestSetup,
                                         callback: @escaping (Result<T.T, Error>) -> Void) {
        guard isConnectedToTheInternet else {
            let error = CustomError(description: "Device is not connected to the internet, Try again later!")
            callback(.failure(error))
            return
        }
        var url: URLRequest
        do {
            url = try setup.asUrlRequest()
        } catch let error {
            callback(.failure(CustomError(description: error.localizedDescription)))
            return
        }
        
        let validationRange = [200...400, 402...500].joined()
        
        sessionManager.request(url, interceptor: interceptor)
            .validate(statusCode: validationRange)
            .responseString(completionHandler: { response in
                Logger.log(.warning, response)
            })
            .responseData { response in
                Logger.log(.warning, response.response?.headers)
                guard let httpResponse = response.response else {
                    callback(.failure(CustomError(description: "No Http response")))
                    return}
                dump.mapData(result: response, response: httpResponse, callback: callback)
            }
    }
}

class Interceptor: RequestInterceptor {
    private var userManager: UserManager = inject()
    private var authManager: AuthManager = inject()
    
    func adapt(_ urlRequest: URLRequest,
               using state: RequestAdapterState,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        let token = userManager.idToken ?? ""
        let bearerToken = "Bearer \(token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        Logger.log(.info, bearerToken)
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < 3, request.response?.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        
        refreshToken { isSuccess in
            isSuccess ? completion(.retry) : completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        authManager.refreshToken {
            completion(true)
        }
    }
}

