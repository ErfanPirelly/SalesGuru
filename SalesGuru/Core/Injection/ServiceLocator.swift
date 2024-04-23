import Foundation

class ServiceLocator {
    static let shared = ServiceLocator()

    private var registry: [String: Any] = [:]

    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }

    func registerService<T>(service: T) {
        let key = typeName(some: T.self)
        registry[key] = service
    }

    func tryGetService<T>() -> T? {
        let key = typeName(some: T.self)
        return registry[key] as? T
    }

    func getService<T>() -> T {
        let t = typeName(some: T.self)
        
        return tryGetService()!
    }

    func unRegisterService<T>(service: T) {
        let key = typeName(some: T.self)
        registry.removeValue(forKey: key)
    }
}
