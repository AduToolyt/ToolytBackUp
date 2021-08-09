//
//  SignUpCell.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

class SignUpCell: ConstrainedTableViewCell {

    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var txtTerms: UITextView!
    
    var data: SignUpData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SignUpCell {
    
    func prepareSignUpData() {
        switch data.signUpCells[tag] {
        case .fieldCell:
            tfFullName.text = data.signUp.fullName
            tfEmail.text = data.signUp.email
            tfPassword.text = data.signUp.password
        case .infoCell:
            let linkAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.003921568627, green: 0.7294117647, blue: 0.937254902, alpha: 1)]
            txtTerms.linkTextAttributes = linkAttributes
            txtTerms.attributedText = data.attributedTerms
        default:
            break
        }
    }
}

extension SignUpCell {
    
    @IBAction func btnTogglePassword(_ sender: UIButton) {
        tfPassword.isSecureTextEntry.toggle()
    }
}

extension SignUpCell: UITextFieldDelegate {
    
    @IBAction func tfEditingChange(_ textField: UITextField) {
        let enteredString = textField.text!.trimmedString()
        if textField == tfFullName {
            data.signUp.fullName = enteredString
        } else if textField == tfEmail {
            data.signUp.email = enteredString
        } else {
            data.signUp.password = enteredString
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
           return textField.resignFirstResponder()
        } else {
            if textField == tfFullName {
                return tfEmail.becomeFirstResponder()
            } else {
                return tfPassword.becomeFirstResponder()
            }
        }
    }
}


extension SignUpCell: UITextViewDelegate {
    
    func redirectUrl() {
        let url = URL(string: "https://www.google.com")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        kprint(items: URL.absoluteString)
        let strPath = URL.absoluteString.isEqual("term") ? "terms_condition" : "privacy_policy"
        kprint(items: "Clicked Link \(strPath)")
        redirectUrl()
        return false
    }
}
