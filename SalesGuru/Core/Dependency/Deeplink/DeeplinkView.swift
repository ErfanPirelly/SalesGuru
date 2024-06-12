//
//  DeepLinkView.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/9/24.
//

import UIKit

typealias DeepLinkViewControllerCallback = ((UIViewController?) -> Void)

protocol DeepLinkViewProtocol {
    func getView(callback: @escaping DeepLinkViewControllerCallback)
}

struct ChatDeepLinkView: DeepLinkViewProtocol {
    // MARK: - properties
    let id: String
    
    // MARK: - logic
    func getView(callback: @escaping DeepLinkViewControllerCallback) {
        let view = ConversationVC(viewModel: .init(id: id))
        callback(view)
    }
    
}
