//
//  LanguageVC.swift
//  Toolty
//
//  Created by Nizamudheen on 28/07/21.
//

import Foundation
import UIKit

class LanguageVC: ParentUIController{
    var languageData = LanguageData()
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var languageTableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        languageTableView.dataSource = self
        languageTableView.delegate = self
        languageTableView.tableFooterView = UIView()
        lblTitle.text = "SwitchLanguageTxt".localized()
    }
    
    @IBAction override func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LanguageVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languageData.laguageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "langaugeTableCell", for: indexPath) as! LangaugeTableCell
        cell.prepareLanguageCell(language: languageData.languageType[indexPath.row].langId,id: languageData.laguageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("\(indexPath.row) :: \(languageData.languageType[indexPath.row].langId) :: \(languageData.laguageArray[indexPath.row])")
        _userDefault.set(languageData.laguageArray[indexPath.row], forKey: ToolytSelectedLang)
        updateLanguage()
        
        }
    func updateLanguage(){
        showActivityHud()
        languageData.getUpdateLanguage { response, dict in
            self.hideActivityHud()
            if response == .success{
                JTValidationToast.show(message: kUpdateLanguage,type: .success)
                
            }else{
                JTValidationToast.show(message: kUpdateFailedLanguage)
               // callBack()
            }
            debugPrint("\(response) :: \(dict)")
            self.languageTableView.reloadData()
            self.callBack()
            
    }
    
    }
    
    func callBack(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
