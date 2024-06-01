//
//  UserFlow.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/25/24.
//

import UIKit
import FirebaseAuth
//import GoogleSignIn
import FirebaseCore

enum UserFlow {
    case home
    case updateProfile(info: IMPersonalInformation)
    case login
    case signUp
    case mobile
    case forgotPassword
    case verify(info: IMPersonalInformation)
    case updatePhone(phone: String)
    case error(message: String)
    case privacy
    case terms
}

protocol UserFlowPresenter: AnyObject {
    var action: ((UserFlow) -> Void)! {get set}
}

extension UserFlowPresenter where Self: UIViewController {}

extension UserFlowPresenter {
    var auth: AuthManager {
        return inject()
    }
    
    var userManager: UserManager {
        return inject()
    }
    
    var network: NetworkCore {
        return NetworkCore(database: .salesguru)
    }
    
    func parseAuthData(with result: Result<AuthDataResult?, Error>,
                       info: IMPersonalInformation = .init(privacyAccepted: false)) {
        switch result {
        case .success(let success):
            guard let result = success else {
                Logger.log(.error, "no response")
                action?(.error(message: "no response"))
                return }
            let user = result.user
            userManager.uid = user.uid
            userManager.email = user.email
            userManager.photoUrl = user.photoURL?.absoluteString
            userManager.phoneNumber = user.phoneNumber
            userManager.isUserLoggedIn = true
            Logger.log(.info, user.uid, user.email, user.phoneNumber, user.displayName)
            handleUserFlow(user: user, info: info)
        case .failure(let failure):
            Logger.log(.error, failure.localizedDescription)
            action?(.error(message: failure.localizedDescription))
        }
    }
    
    public func handleUserFlow(user: User, info: IMPersonalInformation) {
//        var email = user.email
////        if email?.contains("privaterelay.appleid.com") ?? false {
////            email = nil
////        }
//        Logger.log(.info, user)
//
//        if user.displayName == nil {
//            action(.updateProfile(info: info))
//        } else {
//        }
        getUser(uid: user.uid)
    }
    
    public func getUser(uid: String) {
        Logger.log(.error, uid, userManager.uid)
        let path = "pUserCampaigns/\(uid)"
//        network.observe(UserProfileParser(),
//                        childPath: path) {[weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let success):
//                if success.domainUrl == nil {
//                    self.action(.companyInformation)
//                } else {
//                    self.action(.myProject)
//                }
//            case .failure(let failure):
//                action!(.error(message: failure.localizedDescription))
//            }
//        }
    }
}
