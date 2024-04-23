//
//  TintButton.swift
//  Pirelly
//
//  Created by shndrs on 6/17/23.
//

class TintButton: BaseButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

// MARK: - Methods

extension TintButton {
    
    override func setup() {
        super.setup()
        self.backgroundColor = .ui.clear
        self.titleLabel?.textColor = .ui.darkText
        self.titleLabel?.font = .Fonts.medium(15)
    }
    
}

// MARK: - Cancel Button

final class CancelButton: TintButton {
    
    override func setup() {
        super.setup()
        self.backgroundColor = .ui.clear
        self.titleLabel?.textColor = .ui.red
        self.titleLabel?.font = .Fonts.medium(15)
    }
    
}

// MARK: - Cancel Button

final class PirellyTintButton: TintButton {
    
    override func setup() {
        super.setup()
        self.backgroundColor = .ui.clear
        self.titleLabel?.textColor = .ui.primaryBlue
        self.titleLabel?.font = .Fonts.medium(15)
    }
    
}
