//
//  ErrorView.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import Foundation

protocol ErrorView: BaseView {
    func showError(message: String)
    func show(info message: String)
}
