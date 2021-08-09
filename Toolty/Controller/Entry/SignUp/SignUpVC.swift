//
//  SignUpVC.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

class SignUpVC: ParentViewController {

    var signUpData = SignUpData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
}

extension SignUpVC {
    
    func prepareUI() {
        setKeyboardNotifications()
    }
    
    func navigateToOtp() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "otpSegue", sender: nil)
        }
    }
}

extension SignUpVC {
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        let validateData = signUpData.signUp.validateData()
        if validateData.isValid {
            showHud()
            self.signUpData.registerUser { (response) in
                self.hideHud()
                if response == .success {
                    self.navigateToOtp()
                } else {
                    kprint(items: "error")
                }
            }
        } else {
            kprint(items: validateData.error)
        }
    }
    
}

extension SignUpVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signUpData.signUpCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return signUpData.signUpCells[indexPath.row].cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SignUpCell
        let cellId = signUpData.signUpCells[indexPath.row].cellId
        cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SignUpCell
        cell.tag = indexPath.row
        cell.data = signUpData
        cell.prepareSignUpData()
        return cell
    }
    
}
