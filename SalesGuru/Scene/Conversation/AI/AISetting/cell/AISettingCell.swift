//
//  AISettingCell.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 6/3/24.
//


import UIKit
import RxSwift

protocol AISettingCellDelegate: AnyObject {
    func didChangeValue(for setting: IMAISetting)
}

class AISettingCell: UITableViewCell {
    // MARK: - properties
    static let CellID = "AISettingCell"
    private let title = UILabel(font: .Quicksand.normal(17), textColor: .ui.darkColor, alignment: .left)
    private let subtitle = UILabel(font: .Quicksand.normal(11), textColor: .ui.darkColor2, alignment: .left)
    private let line = UIView()
    private var switchView: CustomUISwitch!
    private var stack: UIStackView!
    private let cardView = UIView()
    private var setting: IMAISetting?
    private var bag = DisposeBag()
    weak var delegate: AISettingCellDelegate?
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    // MARK: - setup UI
    private func setUpView() {
        setupCardView()
        setupStack()
        setupSwitchView()
        setupLine()
        setupConstraints()
    }
    
    private func setupStack() {
        stack = .init(axis: .vertical,
                      alignment: .leading,
                      distribution: .equalSpacing,
                      spacing: 8,
                      arrangedSubviews: [title, subtitle])
        cardView.addSubview(stack)
    }
    
    private func setupSwitchView() {
        switchView = .init(onTintColor: .ui.primaryBlue,
                           offTintColor: .ui.darkColor1.withAlphaComponent(0.17),
                           thumbTintColor: .white,
                           thumbCornerRadius: 5.8,
                           thumbSize: .init(width: 11.6, height: 11.6),
                           padding: 3,
                           isOn: false,
                           animationDuration: 0.3)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(switchView)
    }
    
    private func setupCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
    }
    
    private func setupLine() {
        self.line.translatesAutoresizingMaskIntoConstraints = false
        self.line.backgroundColor = .init(p3: "#0000001F")
        cardView.addSubview(line)
    }
    
    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(11.5)
            make.leading.trailing.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(30)
        }
        
        line.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(0.7)
            make.leading.equalTo(stack)
            make.trailing.equalTo(switchView)
        }
        
        switchView.snp.makeConstraints { make in
            make.centerY.equalTo(stack)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(16)
            make.width.equalTo(29)
        }
    }
    
    func fill(cell with: IMAISetting) {
        self.setting = with
        self.title.text = with.title
        self.subtitle.text = with.subtitle
        self.switchView.isOn.accept(with.isOn)
        
        self.switchView.isOn.skip(1).asDriver(onErrorJustReturn: false).drive(onNext: {[weak self] isOn in
            guard let self = self, var setting = self.setting else { return }
            setting.isOn = isOn
            self.delegate?.didChangeValue(for: setting)
        }).disposed(by: bag)
    }
}
