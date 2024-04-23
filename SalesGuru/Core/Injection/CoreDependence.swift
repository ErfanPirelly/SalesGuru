import Foundation
import Alamofire

class CoreDependence: DependenceProviders {

    let window: UIWindow?
    
    init(_ window: UIWindow?) {
        self.window = window
    }

    func execute() {
        let defaultsStore = UserManager.shared
        let fileManager = FileManagerService.shared

        registerService(service: fileManager)
        registerService(service: defaultsStore)
    }
}


extension CoreDependence {
    static func reset() {
        let defaultsStore = UserManager.shared
        let fileManager = FileManagerService.shared

        fileManager.deleteAllFiles()
        fileManager.deleteAppFiles()
        defaultsStore.deleteUser()
    }
}
