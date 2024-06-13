//
//  SplashVC.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/1/24.
//

import UIKit

class SplashVC: UIViewController {
    // MARK: - properties
    @IBOutlet weak var versionLabel: UILabel!
    private let userManager: UserManager = inject()
    private let auth: AuthManager = inject()
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Logger.log(.info, auth.auth.currentUser?.email, auth.auth.currentUser?.uid)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
#if DEBUG
            self.testFlow()
#else
            self.getApiVersion()
#endif
        }
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        versionLabel.text = Utils.versionString
    }
    
    
    private func getUser() {
        if let uid = userManager.uid, userManager.isUserLoggedIn {

        } else {
            goToLogin()
        }
    }
    
    private func checkCompanyInformation(uid: String) {}
    
    private func presentHome() {
        let view = HomeVC()
        let navigation = CleanNavigation(rootViewController: view)
        self.view.window?.switchRootViewController(navigation, options: .curveEaseInOut)
    }
    
    private func goToUpdateProfile() {}
    
    private func goToUpdateCompanyInformation() { }
    
    private func goToLogin() {}
    
    private func presentForceUpdate() {}
    
    private func getApiVersion() {}
    
}


private extension SplashVC {
    func testFlow() {
        let view = HomeVC()
        let navigation = CleanNavigation(rootViewController: view)
        self.view.window?.switchRootViewController(navigation, options: .curveEaseInOut)
    }
}

