//
//  RoundImageView.swift
//  Pirelly
//
//  Created by mmdMoovic on 8/27/23.
//

import UIKit

class RoundImageView: UIView {
    private let imageView = UIImageView()
    var image: UIImage {
        didSet {
            self.imageView.image = image
        }
    }
    
    var size: CGSize
    
    override var tintColor: UIColor! {
        get {
            imageView.tintColor
        }
        
        set {
            imageView.tintColor = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCorner(frame.size.width/2)
    }
    
    init(image: UIImage, size: CGSize) {
        self.size = size
        self.image = image
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: size.width),
            imageView.heightAnchor.constraint(equalToConstant: size.height),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
