//
//  RequestAdapter.swift
//  Pirelly
//
//  Created by shndrs on 8/28/23.
//

import Alamofire
import UIKit

//final class SRRequestAdapter: RequestAdapter, RequestRetrier {
//    
//    typealias RefreshCompletion = (_ succeeded: Bool,
//                                   _ accessToken: String?,
//                                   _ refreshToken: String?) -> Void
//    
//    private let lock = NSLock()
//    static let shared = SRRequestAdapter()
//    
//    private lazy var database: LightStorage = {
//        return LightStorage()
//    }()
//    var accessToken: String? {
//        get {
//            return database[.accessToken]
//        }
//        set {
//            database[.accessToken] = newValue ?? ""
//        }
//    }
//    var refreshToken: String? {
//        get {
//            return database[.refreshToken]
//        }
//        set {
//            database[.refreshToken] = newValue ?? ""
//        }
//    }
//    private var isRefreshing = false
//    private var requestsToRetry: [RequestRetryCompletion] = []
//
//    init() {
//        let sessionManager = Alamofire.Session.default
//        sessionManager.adapter = self
//        sessionManager.retrier = self
//    }
//
//    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//        var urlRequest = urlRequest
//        if let urlString = urlRequest.url?.absoluteString,
//            urlString.hasPrefix(Routes().base),
//            !urlString.hasSuffix(Routes().refreshToken) {
//            if let token = accessToken {
//                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//            }
//        }
//        return urlRequest
//    }
//
//    // MARK: - Request Retrier
//
//    func should(_ manager: Session, retry request: Request,
//                with error: Error, completion: @escaping RequestRetryCompletion) {
//        lock.lock()
//        defer { lock.unlock() }
//        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
//            requestsToRetry.append(completion)
//            if !isRefreshing {
//                refreshTokens { [weak self] succeeded, accessToken, _  in
//                    guard let self = self else { return }
//                    self.lock.lock() ; defer { self.lock.unlock() }
//                    if let accessToken = accessToken {
//                        self.accessToken = accessToken
//                    }
//                    self.requestsToRetry.forEach { $0(succeeded, 0.0) }
//                    self.requestsToRetry.removeAll()
//                }
//            }
//        } else {
//            completion(false, 0.0)
//        }
//    }
//
//    // MARK: - Private Refresh Tokens
//
//    private func refreshTokens(completion: @escaping RefreshCompletion) {
//        guard !isRefreshing else { return }
//        isRefreshing = true
////        let params = SMLogin(email: database[.email] ?? ""
////                             password: database[.password] ?? Strings.placeholder)
////        let setup = RequestSetup(route: Routes().refreshToken, params: params)
////        NetworkCore<RMLogin>.connect(setup: setup) { response, error in
////            if error != nil {
////                completion(false, nil, nil)
////            } else {
////                self.database[.refresh] = response?.refresh ?? Strings.placeholder
////                self.database[.access] = response?.access ?? Strings.placeholder
////                completion(true, response?.access, response?.refresh)
////            }
////            self.isRefreshing = false
////        }
//    }
//    
//}
