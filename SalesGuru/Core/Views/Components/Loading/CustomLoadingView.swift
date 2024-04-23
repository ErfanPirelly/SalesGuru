//
//  CustomLoadingView.swift
//  Pirelly
//
//  Created by mmdMoovic on 1/15/24.
//

import UIKit
import SDWebImage

class CustomLoadingView: UIView {
    // MARK: - properties
    private let imageView = UIImageView()
    private let label = UILabel(text: "Loading...", font: .Fonts.medium(32), textColor: .white, alignment: .center)
    private let imageWidth = 250
    private let imageHeight = 210
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup UI
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black.withAlphaComponent(0.6)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sd_setImage(with: Bundle.main.url(forResource: "logo", withExtension: "gif"))
        
        applyCorners(to: .all, with: 18)
        let stack = UIStackView(axis: .vertical, alignment: .center, distribution: .equalSpacing, spacing: -24, arrangedSubviews: [imageView, label])
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
        }
        
        snp.makeConstraints { make in
            make.width.equalTo(imageWidth + 96)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageHeight)
        }
    }
}


protocol CustomLoadingProtocol {}

extension CustomLoadingProtocol where Self: UIView {
    func startLoading() {
        if viewWithTag(11) == nil {
            let lockView = UIView()
            lockView.backgroundColor = UIColor.black.withAlphaComponent(0.88)
            lockView.tag = 11
            lockView.alpha = 0.0
            addSubview(lockView)
            lockView.pinToEdge(on: self)
            let activity = CustomLoadingView()
            lockView.addSubview(activity)
            activity.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }
    
    func stopLoading() {
        if let lockView = viewWithTag(11) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }) { _ in
                lockView.removeFromSuperview()
            }
        }
    }
}
