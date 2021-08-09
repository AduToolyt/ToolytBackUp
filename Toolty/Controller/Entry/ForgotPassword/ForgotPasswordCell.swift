//
//  ForgotPasswordCell.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

class ForgotPasswordCell: ConstrainedTableViewCell {
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var btnGetOTP: UIButton!
    
    weak var parent: ForgotPasswordVC!
    var data: ForgotPasswordData!
    
    func prepareUI() {
        if self.tag == 0 {
            if parent.counter == 1{
                data.forgotPassword.userName = ""
                tfUserName.placeholder = "Enter Otp"
                tfUserName.keyboardType = .numberPad
            }else if parent.counter == 2{
                data.forgotPassword.userName = ""
                tfUserName.placeholder = "New Password"
                tfUserName.isSecureTextEntry = true
                tfUserName.keyboardType = .default
            }else{
                tfUserName.placeholder = "EnterForgotUsernameTxt".localized()
                tfUserName.layer.borderWidth = 1
                tfUserName.layer.borderColor = UIColor.lightGray.cgColor
                tfUserName.layer.cornerRadius = 5
            }
        }else {
            if parent.counter > 0{
                btnGetOTP.setTitle("Submit", for: .normal)
            }else{
                let btnText = "GetOtpTxt".localized()
                btnGetOTP.setTitle("\(btnText)", for: .normal)
            }
            
        }
    }
}

extension ForgotPasswordCell {
    func prepareForgotPasswordData() {
        switch data.forgotCells[tag] {
        case .fieldCell:
            tfUserName.text = data.forgotPassword.userName
        default:
            break
        }
    }
}

extension ForgotPasswordCell: UITextFieldDelegate {
    
    @IBAction func tfEditingChange(_ textField: UITextField) {
        let enteredString = textField.text!.trimmedString()
        data.forgotPassword.userName = enteredString
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

