//
//  LoginConfirmData.swift
//  Toolty
//
//  Created by Hitesh Khunt on 06/07/21.
//

import UIKit

class LoginConfirmData: NSObject {
    var loginConfirm = LoginConfirm()
    var labels: [NSDictionary] = []
    
}

//MARK: Api calling function
extension LoginConfirmData {
    
    func locationVerfiy(completion: @escaping(ResponseType) -> ()) {
        KPWebCall.call.loginVerifyFetchLocation(param: loginConfirm.paramAttendaceVerifyDict()) { (json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200, let responseDict = dict["user"] as? NSDictionary {
                if let token = responseDict["access_token"] as? String {
                    _appDelegator.storeAuthorizationToken(strToken: token)
                    KPWebCall.call.setAccesTokenToHeader(token: token)
                }
                _user = User.addUpdateEntity(key: "id", value: responseDict.getStringValue(key: "id"))
                _user.initWith(dict: responseDict)
                _appDelegator.saveContext()
                
                if let manageLabels = dict["manageLabels"] as? [NSDictionary]{
                    for dictData in manageLabels{
                        _labels = LabelData.addUpdateEntity(key: "id", value: dictData.getStringValue(key: "id"))
                        _labels.initWith(dict: dictData)
                        _appDelegator.saveContext()
                    }
                    _labels.values = manageLabels as NSArray
                }
                if let privilegeDict = dict["privilege"] as? NSDictionary{
                    _privilege = Privilege.addUpdateEntity(key: "productView", value: privilegeDict.getStringValue(key: "product_view"))
                    _privilege.initWith(dict: privilegeDict)
                    _appDelegator.saveContext()
                }
                if let mapOption = dict["mapOptions"] as? [NSDictionary]{
                    
                    for dictData in mapOption{
                        _mapOption = MapsOption.addUpdateEntity(key:"nearbyTypes", value: dictData.getStringValue(key: "near_by_types"))
                        _mapOption.initWith(dict: dictData)
                        _appDelegator.saveContext()
                    }
                }
                if let opportunity = dict["opportunityOptions"] as? NSDictionary{
                    _oppOption = OpporunityOption.addUpdateEntity(key: "productPrice", value: opportunity.getStringValue(key: "product_price"))
                    _oppOption.initWith(dict: opportunity)
                    _appDelegator.saveContext()
                }
                
                if let signIn = dict["signIn"] as? NSDictionary{
                    if let strTime = signIn["signin_time"] as? String, let strDate = signIn["date"] as? String{
                        _userDefault.set(strTime, forKey: "signInTime")
                        _userDefault.set(strDate, forKey: "signInDate")
                    }
                    
                }
                completion(.success)
            } else {
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error)
            }
        }
    }
    
    func attendanceConfirm(image: UIImage?,completion : @escaping(ResponseType) -> ()){
        KPWebCall.call.attendanceSelfie(param: loginConfirm.paramDict(), image: image) { (json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                completion(.success)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error)
            }
        }
    }
}
