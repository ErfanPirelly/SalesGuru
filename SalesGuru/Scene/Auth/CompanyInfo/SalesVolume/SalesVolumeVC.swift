//
//  SalesVolumeVC.swift
//  Pirelly
//
//  Created by mmdMoovic on 10/27/23.
//

import UIKit

class SalesVolumeVC: UIViewController {
    // MARK: - properties
    private let titleLabel = UILabel(text: "Sales Volume", font: .Fonts.bold(24), textColor: .ui.darkColor4, alignment: .center)
    private let pickerView = UIPickerView()
    var caLayer = CALayer()
    let viewModel: CompanyInformationVM
    
    // MARK: - init
    init(viewModel: CompanyInformationVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        viewModel.salesVolume.accept(viewModel.salesVolumes[0])
    }
    
    // MARK: - prepare UI
    private func prepareUI() {
        view.backgroundColor = .white
        view.applyCorners(to: .all, with: 24)
        view.snp.makeConstraints { make in
            make.width.equalTo(K.size.portrait.width - 60)
            make.height.equalTo(K.size.portrait.height * 0.545)
        }
        // subviews
        setupTitle()
        setupPickerView()
    }
    
    private func setupTitle() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(24)
        }
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tintColor = .white
        caLayer = CALayer()
        caLayer.backgroundColor = UIColor.gray.cgColor
        caLayer.frame = .init(origin: .zero, size: CGSize(width: 162, height: 76))
        
//        pickerView.layer.addSublayer(caLayer)
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.height.equalTo(K.size.portrait.height * 0.545 - 135)
            make.leading.trailing.bottom.equalToSuperview().inset(24)
        }
    }
}

// MARK: - picker view delegate
extension SalesVolumeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.salesVolumes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        76
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        162
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        pickerView.layer.sublayers?.first?.backgroundColor = UIColor.clear.cgColor
        pickerView.layer.sublayers?.last?.backgroundColor = UIColor.clear.cgColor

        if let view = view as? UILabel {
            view.text = "\(row)"
            view.font = .Fonts.medium(20)
            return view
        } else {
            let line = UIView()
            line.backgroundColor = UIColor(p3: "#D9D9D9")
            let label = UILabel(text: "\(viewModel.salesVolumes[row])", font: .Fonts.medium(20), textColor: .ui.darkColor4, alignment: .center)
            label.backgroundColor = .white
            label.addSubview(line)
            
            line.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(1)
            }
            
            label.snp.makeConstraints { make in
                make.width.equalTo(162)
                make.height.equalTo(76)
            }
            return label
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.salesVolume.accept(viewModel.salesVolumes[row])
    }
}
