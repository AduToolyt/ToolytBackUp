//
//  LanguageSelectVC.swift
//  Toolty
//
//  Created by Hitesh Khunt on 01/07/21.
//

import UIKit

class LanguageSelectVC: ParentViewController {
    var languageData = LanguageData()
    @IBOutlet weak var lblTitle : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = "SelectLanguageTxt".localized()
        getVersion()
    }
    
}

// MARK: UITableview Delegate & Datasource Method
extension LanguageSelectVC {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LanguageCell
        let cellId = languageData.languageCells[indexPath.row].cellId
        cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LanguageCell
        cell.parent = self
        cell.tag = indexPath.row
        return cell
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageData.languageCells.count
    }
}


// MARK: Button Tapped Action Methods
extension LanguageSelectVC {
    func getVersion(){
        self.showHud()
        self.languageData.getAppVersion {[weak self] (response,dict) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                let objDict = AppVersionData(dict: dict)
                _userDefault.set(objDict.versionId, forKey: "AppVersionID")
            } else{
                JTValidationToast.show(message: dict.getStringValue(key: "error"))
            }
        }
    }
}

//MARK:- All Button Action Method Called
extension LanguageSelectVC {
    @IBAction func btnLanguageSelect(_ sender: UIButton) {
        _appDelegator.navigateUserToHome()
//        getUpdateLanguage_Api()
    }
}


//MARK:- Get AppVersion
extension LanguageSelectVC{
    func getUpdateLanguage_Api(){
        self.showHud()
        self.languageData.getUpdateLanguage {[weak self] (response,dict) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                let objDict = AppVersionData(dict: dict)
                _userDefault.set(objDict.versionId, forKey: "AppVersionID")
                if let version = _userDefault.value(forKey: "AppVersionID") as? String {
                    _appDelegator.navigateUserToHome()
                }
            } else {
                JTValidationToast.show(message: dict.getStringValue(key: "error"))
            }
        }
    }
}


