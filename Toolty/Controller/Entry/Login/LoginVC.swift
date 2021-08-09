//
//  LoginVC.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

class LoginVC: ParentViewController {
    @IBOutlet weak var lblVersion : UILabel!

    var loginData = LoginData()
    var versionData : AppVersionData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        getVersion()
    }
}

extension LoginVC {
    
    func prepareUI() {
        setKeyboardNotifications()
    }
}


extension LoginVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginData.loginCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return loginData.loginCells[indexPath.row].cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LoginCell
        let cellId = loginData.loginCells[indexPath.row].cellId
        cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LoginCell
        cell.tag = indexPath.row
        cell.data = loginData
        cell.prepareUI()
        cell.prepareLoginData()
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resignFirstResponder()
        self.view.resignFirstResponder()
        self.view.endEditing(true)
                    self.tableView.endEditing(true)
    }
}
//MARK:- All Button Action Method Called
extension LoginVC {
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        callVerifyUser_Api()
    }
    
    @IBAction func btnForgotPassword(_ sender: UIButton){
//        self.performSegue(withIdentifier: "forgot", sender: nil)
    }
}

//MARK:- Get AppVersion
extension LoginVC{
    func getVersion(){
        self.showHud()
        self.loginData.getAppVersion {[weak self] (response,dict) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                let objDict = AppVersionData(dict: dict)
                _userDefault.set(objDict.versionId, forKey: "AppVersionID")
                if let version = _userDefault.value(forKey: "AppVersionID") as? String {
                    weakSelf.lblVersion.text = "V" + version
                }
            } else{
                JTValidationToast.show(message: dict.getStringValue(key: "error"))
            }
        }
    }
    
    func callVerifyUser_Api()  {
        let validateData = loginData.login.validateData()
        if validateData.isValid {
            showHud()
            self.loginData.loginUser { (response) in
                self.hideHud()
                if response == .success {
                    _appDelegator.navigateUserToHome()
                } else {
                    self.hideHud()
                }
            }
        } else {
            
            JTValidationToast.show(message: validateData.error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginConfirm"{
            let vc = segue.destination as! LoginConfirmVC
            vc.modalPresentationStyle = .fullScreen
        }
    }
}
     
