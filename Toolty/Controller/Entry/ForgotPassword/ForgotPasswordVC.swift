//
//  ForgotPasswordVC.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit
import MapKit

class ForgotPasswordVC: ParentViewController {
    var forgotData = ForgotPasswordData()
    @IBOutlet weak var lblTitle: UILabel!
    var counter : Int = 0
    var otpNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = "ForgotHeaderTxt".localized()
        prepareUI()
    }
}

extension ForgotPasswordVC {
    
    func prepareUI() {
        
        setKeyboardNotifications()
    }
}

extension ForgotPasswordVC {
    
    @IBAction func btnRecoveryTapped(_ sender: UIButton) {
        if counter == 0{
            let validateData = forgotData.forgotPassword.validateData()
            if validateData.isValid {
                showHud()
                self.forgotData.recoverPassword {[unowned self] (response,otp,compId,leadId) in
                    self.hideHud()
                    if response == .success {
                        self.counter = counter + 1
                        self.otpNumber = otp
                        self.forgotData.forgotPassword.compId = "\(compId)"
                        self.forgotData.forgotPassword.leadId = "\(leadId)"
                        self.tableView.reloadData()
                        kprint(items: "success")
                    } else {
                        kprint(items: "error")
                    }
                }
            } else {
                JTValidationToast.show(message: validateData.error)
                kprint(items: validateData.error)
            }
        }else if counter == 1{
            let validateData = forgotData.forgotPassword.validateData()
            if validateData.isValid{
                if forgotData.forgotPassword.userName == "\(otpNumber)"{
                    counter = counter + 1
                    self.tableView.reloadData()
                }else{
                    self.showMessage(title: "Invalid OTP", msg: "")
                }
            }else{
                self.showMessage(title: "Please enter OTP", msg: "")
            }
        }else if counter == 2{
            let validatePassword = forgotData.forgotPassword.validateData()
            if validatePassword.isValid{
                showHud()
                self.forgotData.changeNewPassword { (response) in
                    if response == .success{
                        self.navigationController?.popViewController(animated: true)
                    }else{
                        self.showMessage(title: "Failed to Change Password", msg: "")
                    }
                }
            }else{
                self.showMessage(title: "Please enter New Password", msg: "")
            }
        }
    }
}

extension ForgotPasswordVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forgotData.forgotCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return forgotData.forgotCells[indexPath.row].cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ForgotPasswordCell
        let cellId = forgotData.forgotCells[indexPath.row].cellId
        cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ForgotPasswordCell
        cell.parent = self
        cell.tag = indexPath.row
        cell.data = forgotData
        cell.prepareUI()
        cell.prepareForgotPasswordData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resignFirstResponder()
        self.view.resignFirstResponder()
        self.view.endEditing(true)
        self.tableView.endEditing(true)
    }
}

//MARK:- Alert Methods
extension ForgotPasswordVC{
    func showMessage(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


