import Foundation

func registerService<T>(service: T) {
    ServiceLocator.shared.registerService(service: service)
}

func inject<T>() -> T {
    return ServiceLocator.shared.getService()
}

func optionalInject<T>() -> T? {
    return ServiceLocator.shared.tryGetService()
}
