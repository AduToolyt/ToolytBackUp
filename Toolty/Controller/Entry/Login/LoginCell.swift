//
//  LoginCell.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

class LoginCell: ConstrainedTableViewCell {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnRemember: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnHideShow: UIButton!
    @IBOutlet weak var btnMarkLeave: UIButton!
    @IBOutlet weak var btnForgotPasswrod: UIButton!
    
    var data: LoginData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareHeaderCell()  {
        lblHeader.text = "LoginHeaderTxt".localized()
        lblTitle.text = "LoginTitleTxt".localized()
    }
    
    func prepareTextfiedCell() {
        tfEmail.placeholder = "LoginUserPlaceTxt".localized()
        tfEmail.layer.borderWidth = 1
        tfEmail.layer.borderColor = UIColor.lightGray.cgColor
        tfEmail.layer.cornerRadius = 5
        
//        btnRemember.layer.borderWidth = 1
//        btnRemember.layer.borderColor = UIColor.lightGray.cgColor
//        btnRemember.layer.cornerRadius = 5
        let btnText = "LoginRememberMeTxt".localized()
        btnRemember.setTitle("\(btnText)", for: .normal)

        tfPassword.placeholder = "LoginPassPlaceTxt".localized()
        tfPassword.layer.borderWidth = 1
        tfPassword.layer.borderColor = UIColor.lightGray.cgColor
        tfPassword.layer.cornerRadius = 5
    }
    
    func prepareButtonCell()  {
        let btnText = "LoginButtonSignInTxt".localized()
        btnSignIn.setTitle("\(btnText)", for: .normal)
    }
    
    func prepareInfoCell()  {
        let btnForgotPass = "LoginlblForgotPassTxt".localized()
        btnForgotPasswrod.setTitle("\(btnForgotPass)", for: .normal)
        let btnMark = "LoginlblMarkLeaveTxt".localized()
        btnMarkLeave.setTitle("\(btnMark)", for: .normal)
    }
    
    func prepareUI() {
        self.tag == 0 ? prepareHeaderCell() : self.tag == 1 ? prepareTextfiedCell() : self.tag == 2 ? prepareButtonCell() : prepareInfoCell()
    }
}

extension LoginCell {
    
    func prepareLoginData() {
        switch data.loginCells[tag] {
        case .fieldCell:
            //btnRemember.isSelected = _userDefault.isRememberChecked()
            if let userName = _userDefault.object(forKey: "userName") as? String{
                btnRemember.isSelected = true
                data.login.userName = userName
                tfEmail.text = data.login.userName
            }else{
                btnRemember.isSelected = false
                tfEmail.text = data.login.userName
            }
            if let password = _userDefault.object(forKey: "passWord") as? String{
                btnRemember.isSelected = true
                data.login.password = password
                tfPassword.text = data.login.password
            }else{
                btnRemember.isSelected = false
                tfPassword.text = data.login.password
            }
        default:
            break
        }
    }
}

extension LoginCell {
    
    @IBAction func btnTogglePassword(_ sender: UIButton) {
        tfPassword.isSecureTextEntry.toggle()
        if sender.isSelected == true {
            btnHideShow.isSelected = false
        } else  {
            btnHideShow.isSelected = true
        }
    }
    
    @IBAction func btnRememberPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            //_userDefault.setIsRememberMe(value: !sender.isSelected)
            _userDefault.set(data.login.userName, forKey: "userName")
            _userDefault.set(data.login.password, forKey: "passWord")
        } else {
            _userDefault.removeObject(forKey: "userName")
            _userDefault.removeObject(forKey: "passWord")
        }
    }
    
    
}

extension LoginCell: UITextFieldDelegate {
    
    @IBAction func tfEditingChange(_ textField: UITextField) {
        let enteredString = textField.text!.trimmedString()
        if textField == tfEmail {
            data.login.userName = enteredString
        } else {
            data.login.password = enteredString
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            return textField.resignFirstResponder()
        } else {
            if textField == tfEmail {
                return  tfPassword.becomeFirstResponder()
            } else {
                return textField.resignFirstResponder()
            }
        }
    }
}

extension UserDefaults{
    func isRememberChecked() -> Bool {
        return bool(forKey: "userName")
    }
    func setIsRememberMe(value: Bool) {
        set(value, forKey: "userName")
        self.synchronize()
    }
}
