//
//  LoginVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/25/24.
//

import Foundation
import FirebaseAuth

final class LoginVM: NSObject {
    let authManager: AuthManager = inject()
    
    func login(with inputs: SMLogin, callback: @escaping authCallback) {
        authManager.signIn(email: inputs.email,
                           password: inputs.password) { [weak self] authResult, error in
            guard let self = self else { return }
            callback(authResult, error)
        }
    }
}
