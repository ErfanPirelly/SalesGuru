//
//  UIsearchBAr+Color.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 5/18/24.
//

import UIKit

extension UISearchBar
{
    func setPlaceholderTextColorTo(color: UIColor) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = color
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = color
    }
    
    func setTextFieldBackColor(color: UIColor) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = color
    }

    func setMagnifyingGlassColorTo(color: UIColor) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = color
    }
    
    var clearButton : UIButton{
         return self.value(forKey: "_clearButton") as! UIButton

     }
     
     var clearButtonTintColor: UIColor? {
            get {
                return clearButton.tintColor
            }
            set {
              var image = clearButton.imageView?.image
                 
         
                 image =  image?.withRenderingMode(.alwaysTemplate)
                clearButton.setImage(image, for: .normal)
                clearButton.tintColor = newValue
          
            }
        }
}
