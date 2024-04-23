//
//  AuthManager.swift
//  Pirelly
//
//  Created by shndrs on 8/2/23.
//

import UIKit
import FirebaseAuth

enum UserType {
    case staff
    case normal
}
typealias authCallback = (_ response: AuthDataResult?,_ error: CustomError?) -> Void

final class AuthManager: NSObject {
    static let shared = AuthManager()
    public var type: UserType = .normal
    private var verificationId: String?
    private var interval: TimeInterval = 3600
    var token: String = ""
    
    public lazy var auth: Auth = {
        return Auth.auth()
    }()
    
    
    private override init() {
        super.init()
        addStateDidChangeListener()
        startTimer()
        if let user = auth.currentUser {
            checkUser(user: user)
        }
    }
    
    private func checkUser(user: User) {
        let uid = user.uid
        type = uid.contains("staff") ? .staff : .normal
    }
}

// MARK: - phone number
extension AuthManager {
    func verify(phoneNumber: String,
                completion: @escaping (_ response: String?,
                                       _ error: CustomError?) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber,
                                                       uiDelegate: self) { [weak self] verificationId, error in
            guard self != nil else { return }
            guard let verificationId = verificationId else {
                completion(nil, CustomError(description: error?.localizedDescription ?? ""))
                return
            }
            self?.verificationId = verificationId
            completion(verificationId, nil)
        }
    }
}

// MARK: - email
extension AuthManager {
    func verifyEmail(completion: @escaping (_ error: CustomError?) -> Void) {
        auth.currentUser?.sendEmailVerification(completion: { error in
            if let error = error {
                completion(CustomError(description: error.localizedDescription))
            } else {
                completion(nil)
            }
        })

    }
}

extension AuthManager {
    func forgotPassword(email: String, completion: @escaping (Error?) -> Void) {
        auth.sendPasswordReset(withEmail: email, completion: completion)
    }
    
    func updatePhoneNumber(otp: String,
                           completion: @escaping (Error?) -> Void) {
        guard let verificationId = verificationId else {
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId,
                                                                 verificationCode: otp)
        auth.currentUser?.updatePhoneNumber(credential, completion: completion)
    }
    
    func signIn(otp: String,
                completion: @escaping authCallback) {
        guard let verificationId = verificationId else {
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId,
                                                                 verificationCode: otp)
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(nil, CustomError(description: error?.localizedDescription ?? ""))
                return
            }
            if let user = result?.user {
                self.auth.updateCurrentUser(user)
                self.refreshToken()
                self.checkUser(user: user)
            }
            completion(result, nil)
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping authCallback) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            guard authResult != nil, error == nil else {
                completion(nil, CustomError(description: error?.localizedDescription ?? ""))
                return
            }
            if let user = authResult?.user {
                self.auth.updateCurrentUser(user)
                self.refreshToken()
                self.checkUser(user: user)
            }
            completion(authResult, nil)
        }
    }
    
    func signUp(email: String,
                password: String,
                completion: @escaping authCallback) {
        auth.createUser(withEmail: email,
                        password: password) { authResult, error in

            guard authResult != nil, error == nil else {
                completion(nil, CustomError(description: error?.localizedDescription ?? ""))
                return
            }
            if let user = authResult?.user {
                self.auth.updateCurrentUser(user)
                self.refreshToken()
                self.checkUser(user: user)
            }
            completion(authResult, nil)
        }
    }
    
    func authenticate(with credential: OAuthCredential, info: IMPersonalInformation,
                      completion: @escaping authCallback) {
        auth.signIn(with: credential) { (authResult, error) in
            guard authResult != nil, error == nil else {
                completion(nil, CustomError(description: error?.localizedDescription ?? ""))
                return
            }
            
            if let user = authResult?.user {
                self.auth.updateCurrentUser(user)
                self.refreshToken()
                self.checkUser(user: user)
            }
            
            self.updateProfile(inputs: info) { _ in
                completion(authResult, nil)
            }
        }
    }
    
    func addStateDidChangeListener() {
        auth.addStateDidChangeListener { auth, user in
            self.refreshToken()
        }
    }
     
    func getIDToken() {
        auth.currentUser?.getIDToken(completion: { idToken, _  in
            UserManager.shared.idToken = idToken
        })
    }
    
    func checkUserInfo(info: IMPersonalInformation = .init(privacyAccepted: false)) -> IMPersonalInformation {
        let fullName = auth.currentUser?.displayName?.split(separator: " ")
        var name: String?
        var lastName: String?
        var email: String? = auth.currentUser?.email
        
        if info.name == nil, let first = fullName?.first {
            name = String(first)
        } else {
            name = info.name
        }
        
        if info.lastName == nil, let last = fullName?.last {
            lastName = String(last)
        } else {
            lastName = info.lastName
        }
        
        if email?.contains("privaterelay.appleid.com") ?? false {
            email = nil
        }
        
        return .init(name: name, lastName: lastName, basePhoneNumber: info.basePhoneNumber, prefixPhoneNumber: info.prefixPhoneNumber,
                     email: email, privacyAccepted: info.privacyAccepted)
    }
}

// MARK: - token
extension AuthManager {
    func refreshToken(_ completion: Action? = nil) {
        auth.currentUser?.getIDToken(completion: { [weak self] token, error in
            guard let self = self else { return }
            if error == nil {
                self.token = token ?? ""
                Logger.log(.success, token)
            } else {
                Logger.log(.error, error?.localizedDescription, "No token")
            }
            completion?()
        })
    }
    
    private func startTimer() {
        refreshToken()
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.refreshToken()
        }
    }
}

// MARK: - updat profile
extension AuthManager {
    func updateProfile(inputs: IMPersonalInformation, completion: @escaping (Result<Bool, Error>) -> Void) {
        updateUsername(inputs: inputs, completion: completion)
//        updateEmail(inputs: inputs) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success:
//                self.updateUsername(inputs: inputs, completion: completion)
//            case .failure(let failure):
//                completion(.failure(failure))
//            }
//        }
    }
    
    func updateUsername(inputs: IMPersonalInformation, completion: @escaping (Result<Bool, Error>) -> Void) {
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        guard let name = inputs.name, let last = inputs.lastName else {
            completion(.failure(CustomError(description: "name is empty")))
            return}
        changeRequest?.displayName = name + " " + last
        changeRequest?.commitChanges { error in
            if error != nil {
                Logger.log(.error, error?.localizedDescription)
                completion(.failure(CustomError(description: "couldn't update the username")))
            }  else {
                completion(.success(true))
            }
        }
    }
    
    func updateEmail(inputs: IMPersonalInformation, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let email = inputs.email else {
            completion(.failure(CustomError(description: "No Email")))
            return
        }
        
        if email != auth.currentUser?.email {
            auth.currentUser?.updateEmail(to: email, completion: { error in
                if error == nil {
                    completion(.success(true))
                } else {
                    completion(.failure(error!))
                }
            })
        } else {
            completion(.success(true))
        }
    }
}

// MARK: - delete User
extension AuthManager {
    func deleteUser(completion: @escaping (Error?) -> Void) {
        self.token = ""
        auth.currentUser?.delete(completion: { error in
            if error == nil {
                CoreDependence.reset()
                completion(nil)
            } else {
                completion(error)
            }
        })
    }
}
// MARK: - AuthUIDelegate
extension AuthManager: AuthUIDelegate {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool) async {
        
    }
    
    func dismiss(animated flag: Bool) async {
        
    }
}
