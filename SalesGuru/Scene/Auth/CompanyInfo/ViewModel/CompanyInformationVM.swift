//
//  CompanyInformationVM.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/27/23.
//

import RxSwift
import RxCocoa

struct companyInformationError: Error {
    let textField: CompanyInformationValidator.TextFields
    let message: String
}

class CompanyInformationVM: NSObject {
    typealias CompanyCallbackResult = (Result<Bool, companyInformationError>) -> Void
    
    // MARK: - properties
    let error = BehaviorRelay<CustomError?>(value: nil)
    let dealerType = BehaviorRelay<String?>(value: nil)
    let salesVolume = BehaviorRelay<String?>(value: nil)
    let bag = DisposeBag()
    
    private lazy var network: NetworkCore = NetworkCore(database: .salesguru)
    private var validator: CompanyInformationValidator = CompanyInformationValidator()
    var dealerTypes = [
        "franchise",
        "private"
    ]
    
    var salesVolumes = [
        "0 - 10",
        "10 - 20",
        "20 - 30",
        "30 - 40",
        "40 - 60",
        "+60"
    ]
    
    // MARK: - init
    func validate(inputs: IMCompanyInformation,
                  result: @escaping CompanyCallbackResult) {
        if let error = validator.validate(inputs: inputs) {
            result(.failure(.init(textField: validator.textFields!, message: error.localizedDescription)))
        } else {
            callAPI(companyInfo: inputs,
                    completion: result)
        }
    }
    
    private func callAPI(companyInfo: IMCompanyInformation,
                         completion: @escaping CompanyCallbackResult) {
        
    }
}
