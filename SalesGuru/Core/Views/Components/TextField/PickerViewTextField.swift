//
//  PickerViewTextField.swift
//  Pirelly
//
//  Created by shndrs on 8/15/23.
//

import UIKit

final class PickerViewTextField: BaseTextField {
    
    private var arrowImageView: UIImageView!
    public typealias TextFiledItemHandler = (_ item: String,_ index: Int) -> Void
    
    var itemSelectionHandler: TextFiledItemHandler?
    var selectedIndex: Int? {
        didSet {
            guard items.count > 0, selectedIndex! < items.count else { return }
            self.pickerView.selectRow(selectedIndex!, inComponent: 0, animated: false)
            self.text = items[selectedIndex!]
            self.itemSelectionHandler?(self.text ?? "" ,selectedIndex!)
        }
    }
    var items: [String]! = [] {
        didSet {
            self.pickerView.list = items
        }
    }
    private lazy var pickerView: BasePickerView = {
        let tmp = BasePickerView()
        return tmp
    }()
    
    override func setup() {
        super.setup()
//        let arrowBackView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 64))
//        arrowBackView.backgroundColor = .clear
//        
//        arrowImageView = UIImageView(frame: CGRect(x: 12, y: 24, width: 16, height: 16))
//        arrowImageView.image = .get(image: .arrow_down)
//        arrowImageView.contentMode = .scaleAspectFit
//        arrowBackView.addSubview(arrowImageView)
//        
//        self.rightView = arrowBackView
//        self.rightViewMode = .always
        self.inputView = self.pickerView
        self.delegate = self
        self.textAlignment = .left
        self.undoManager?.removeAllActions()
        pickerView.selectionChanged = { value, idx in
            self.text = value
            self.selectedIndex = idx
            if self.itemSelectionHandler != nil {
                self.itemSelectionHandler!(value, idx)
            }
        }
    }

}

// MARK: - UITextField Delegate

extension PickerViewTextField: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let currentIndex = self.pickerView.selectedRow(inComponent: 0)
        let idx = (currentIndex == -1) ? 0 : currentIndex
        let value = self.pickerView.list[idx]
        self.text = value
        self.itemSelectionHandler?(value,idx)
    }
    
}
