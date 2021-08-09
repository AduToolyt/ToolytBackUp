//
//  LoginData.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

class LoginData: NSObject {
    
    var login: Login!
    var appVersion : AppVersionData!
    var loginCells: [LoginCells] = []
    var loginConfirm = LoginConfirm()
    
    override init() {
        super.init()
        login = Login()
        loginCells = [.headerCell, .fieldCell, .buttonCell, .infoCell]
    }
    

    enum LoginCells {
        case headerCell
        case fieldCell
        case buttonCell
        case infoCell
        
        var cellId: String {
            switch self {
            case .headerCell:
                return "headerCell"
            case .fieldCell:
                return "fieldCell"
            case .buttonCell:
                return "buttonCell"
            case .infoCell:
                return "infoCell"
            }
        }
        
        var cellHeight: CGFloat {
            switch self {
            case .headerCell:
                return 200.widthRatio
            case .fieldCell:
                return 160.widthRatio
            case .infoCell:
                return 120.widthRatio
            default:
                return 40.widthRatio
            }
        }
    }
}


//MARK: Api calling function
extension LoginData {
    func getAppVersion(completion : @escaping(ResponseType,NSDictionary) -> ()){
        KPWebCall.call.getAppVersion(param: login.paramVersionDict()) {(json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                completion(.success, dict)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error, json as! NSDictionary)
            }
        }
    }
    
    func loginUser(completion: @escaping(ResponseType) -> ()) {
        KPWebCall.call.loginVerifyUser(param: login.paramDict()) { (json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200, let responseDict = dict["user"] as? NSDictionary {
                if let attandanceId = dict["dummy_attendance_id"] as? Int{
                    _userDefault.set("\(attandanceId)", forKey: "attandanceId")
                }
                if let token = responseDict["access_token"] as? String {
                    _appDelegator.storeAuthorizationToken(strToken: token)
                    KPWebCall.call.setAccesTokenToHeader(token: token)
                }
                _user = User.addUpdateEntity(key: "id", value: responseDict.getStringValue(key: "id"))
                _user.initWith(dict: responseDict)
                _appDelegator.saveContext()
                

                if let nextPage = dict["next_page"] as? String{
                    if nextPage == "login_map"{
                        let nav = _appDelegator.window?.rootViewController as! KPNavigationViewController
                        let homeCont = UIStoryboard.init(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "LoginConfirm")
                        nav.viewControllers = [homeCont]
                        _appDelegator.window?.rootViewController = nav
                    }
                }
                
                completion(.success)
            } else {
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error)
            }
        }
    }
    
    
}
