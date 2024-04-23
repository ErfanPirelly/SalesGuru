//
//  Typealias.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

import Foundation
import FirebaseDatabase
import UIKit

typealias Action = (() -> Void)
typealias Actional = (() -> Void)?
typealias Page = UInt16
typealias ListSelectionBlock = (String, Int) -> ()
typealias Success = ((Bool) -> Void)
typealias KingfisherImage = ((UIImage?) ->())
typealias BackFire = (_ response: DataSnapshot?, _ error: CustomError?) -> Void
typealias ErrorAction = (_ error: CustomError?) -> Void

protocol CollectionViewDelegate: UICollectionViewDelegate, UICollectionViewDataSource {}
protocol tableViewDelegate: UITableViewDelegate, UITableViewDataSource {}
