import Foundation
import Alamofire

class CoreDependence: DependenceProviders {

    let window: UIWindow?
    
    init(_ window: UIWindow?) {
        self.window = window
    }

    func execute() {
        let defaultsStore = UserManager()
        let fileManager = FileManagerService.shared
        let authManager = AuthManager(userManager: defaultsStore)
        let customEvent = CustomEvent(window: window)
        let deepLink = DeepLinkDependency(event: customEvent)
        
        registerService(service: fileManager)
        registerService(service: authManager)
        registerService(service: defaultsStore)
        registerService(service: customEvent)
        registerService(service: deepLink)
    }
}


extension CoreDependence {
    static func reset() {
        let defaultsStore: UserManager = inject()
        let fileManager = FileManagerService.shared
        
        fileManager.deleteAllFiles()
        fileManager.deleteAppFiles()
        defaultsStore.deleteUser()
    }
}
