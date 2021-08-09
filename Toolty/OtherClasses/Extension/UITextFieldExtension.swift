//
//  UITextFieldExtension.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit


extension UITextField {
    
    func setAttributedPlaceHolder(text: String, font: UIFont, color: UIColor) {
        let mutatingAttributedString = NSMutableAttributedString(string: text)
        mutatingAttributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, text.count))
        mutatingAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, text.count))
        attributedPlaceholder = mutatingAttributedString
    }
    
}
