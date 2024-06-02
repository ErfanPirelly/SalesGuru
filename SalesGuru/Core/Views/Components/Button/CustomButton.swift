//
//  CustomButton.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/2/24.
//

import UIKit

final class NavBatButton: UIButton {
    typealias NavBatButtonItemAction = ((NavBatButton) -> Void)
    
    private var onSelectedAction: NavBatButtonItemAction?
    private var onDeselectedAction: NavBatButtonItemAction?
    private var onEnabledAction: NavBatButtonItemAction?
    private var onDisabledAction: NavBatButtonItemAction?
    private var onTouchUpInsideAction: NavBatButtonItemAction?
    
    /// Calls the onSelectedAction or onDeselectedAction when set
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            guard newValue != isHighlighted else { return }
            super.isHighlighted = newValue
            if newValue {
                onSelectedAction?(self)
            } else {
                onDeselectedAction?(self)
            }
            
        }
    }
    
    /// Calls the onEnabledAction or onDisabledAction when set
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                onEnabledAction?(self)
            } else {
                onDisabledAction?(self)
            }
        }
    }
    
    /// The title for the UIControlState.normal
    var title: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    /// The image for the UIControlState.normal
    var image: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                onSelectedAction?(self)
            } else {
                onDeselectedAction?(self)
            }
        }
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup ui
    private func setupUI() {
        addTarget(self, action: #selector(touchUpInsideAction), for: .touchUpInside)
    }
    
    @objc private func touchUpInsideAction() {
        onTouchUpInsideAction?(self)
    }
    
    func onSelected(_ action: @escaping NavBatButtonItemAction) -> Self {
        onSelectedAction = action
        return self
    }
    
    func onDeselected(_ action: @escaping NavBatButtonItemAction) -> Self {
        onDeselectedAction = action
        return self
    }
    
    func onEnabled(_ action: @escaping NavBatButtonItemAction) -> Self {
        onEnabledAction = action
        return self
    }
    
    func onDisabled(_ action: @escaping NavBatButtonItemAction) -> Self {
        onDisabledAction = action
        return self
    }
    
    func onTouchUpInside(_ action: @escaping NavBatButtonItemAction) -> Self {
        onTouchUpInsideAction = action
        return self
    }
}
