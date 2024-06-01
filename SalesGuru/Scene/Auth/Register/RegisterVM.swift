//
//  RegisterVM.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import Foundation
import FirebaseAuth

final class RegisterVM: NSObject {
    let authManager: AuthManager = inject()
    
    func register(with inputs: SMLogin, callback: @escaping authCallback) {
        authManager.signUp(email: inputs.email,
                           password: inputs.password) { [weak self] authResult, error in
            guard let self = self else { return }
            callback(authResult, error)
        }
    }
}

