//
//  LoginConfirmVC.swift
//  Toolty
//
//  Created by Hitesh Khunt on 04/07/21.
//

import UIKit
class LoginConfirmVC: ParentViewController {
    @IBOutlet weak var lblHeader : UILabel!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblShowWrong : UILabel!
    @IBOutlet weak var lblLocation : UILabel!
    @IBOutlet weak var btnConfirm : UIButton!
    @IBOutlet weak var btnShowWrongLoc : UIButton!
    @IBOutlet weak var btnReset : UIButton!
    var menuData = AddMenuData()
    var loginConfirmData = LoginConfirmData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblHeader.text = "LoginConfirmHeaderTxt".localized()
        self.lblTitle.isHidden = true
        let btnText = "LoginConfirBtnReset".localized()
        btnConfirm.setTitle("\(btnText)", for: .normal)
        
        let btnShowText = "LoginConfirShowWrongLoc".localized()
        btnShowWrongLoc.setTitle("\(btnShowText)", for: .normal)
        
        let btnRestTxt = "LoginBtnReset".localized()
        btnReset.setTitle("\(btnRestTxt)", for: .normal)
        
        self.getUserCurrLocation(isBool: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.lblTitle.isHidden = false
            self.lblLocation.text = self.getAddress
            self.loginConfirmData.loginConfirm.userlat = self.lattitude
            self.loginConfirmData.loginConfirm.userlong = self.longitude
            self.loginConfirmData.loginConfirm.userlocationName = self.userLocationAddress
        }
    }
}

//MARK:- All Button Action Method Called
extension LoginConfirmVC {
    @IBAction func btnConfirmTapped(_ sender: UIButton) {
        callLoginAttandenceVerify_Api()
    }
    
    @IBAction func btnResetTapped(_ sender: UIButton) {
        self.getUserCurrLocation(isBool: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.lblLocation.text = self.getAddress
            self.loginConfirmData.loginConfirm.userlat = self.lattitude
            self.loginConfirmData.loginConfirm.userlong = self.longitude
            self.loginConfirmData.loginConfirm.userlocationName = self.userLocationAddress
        }
    }
    
    func prepareCamera(){
        let picVC = UIImagePickerController()
        picVC.sourceType = .camera
        picVC.allowsEditing = false
        picVC.cameraCaptureMode = .photo
        picVC.cameraDevice = .front
        picVC.delegate = self
        self.present(picVC, animated: true, completion: nil)
    }
}

//MARK:- UIImagePicker Delegate Methods
extension LoginConfirmVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            self.postAttendance(selfieImg: image)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Get LoginConfirmAttendance Api call
extension LoginConfirmVC {
    func callLoginAttandenceVerify_Api()  {
        let validateData = loginConfirmData.loginConfirm.validateData()
        if validateData.isValid {
            showHud()
            self.loginConfirmData.locationVerfiy { (response) in
                self.hideHud()
                if response == .success {
                    _appDelegator.getDataFromJsonString()
                    self.getAllMenu()
                    //self.prepareCamera()
                } else {
                    self.hideHud()
                }
            }
        }else {
            JTValidationToast.show(message: validateData.error)
        }
    }
    func postAttendance(selfieImg : UIImage?){
        self.showHud()
        self.loginConfirmData.attendanceConfirm(image: selfieImg) { [weak self] (response) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                _appDelegator.setOverLoginStatus(value: true)
                if _appDelegator.isAttendanceOverStatus(){
                    weakSelf.performSegue(withIdentifier: "home", sender: nil)
                }
            }else{
                weakSelf.hideHud()
            }
        }
    }
    
    func getAllMenu(){
        showHud()
        self.menuData.addMenudata {[weak self] (response, arrData) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                print(_appDelegator.arrMenuData.count)
                self?.goNextController()
                _appDelegator.getPrivilegeJsonData(isFromAccount: false)
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
    
    
    func goNextController() {
        self.performSegue(withIdentifier: "home", sender: nil)
    }
}
