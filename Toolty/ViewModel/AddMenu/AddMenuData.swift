//
//  AddMenuData.swift
//  Toolty
//
//  Created by Chirag Patel on 14/07/21.
//

import UIKit

class AddMenuData: NSObject {
    var arrMenuData : [AddMenu] = []
    
    func paramMenuDict() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        return dict
    }

}

//MARK:- AddMenu WebCall Methods
extension AddMenuData{
    func addMenudata(completion : @escaping (ResponseType,[AddMenu]) -> ()){
        KPWebCall.call.getAddMenuData(param: paramMenuDict()) {[weak self] (json , statusCode) in
            guard let weakSelf = self, let dict = json as? NSDictionary else {return}
            if statusCode == 200, let res = dict["menus"] as? [NSDictionary]{
                for dictData in res{
                    if dictData["show_in"] as! Int == 0 || dictData["show_in"] as! Int == 1 || dictData["show_in"] as! Int == 2 {
                        let objMenu = AddMenu(dict: dictData)
                        _appDelegator.arrMenuData.append(objMenu)
                        _appDelegator.moreMenuData.append(objMenu)
                    }
                }
                completion(.success,weakSelf.arrMenuData)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error, [])
            }
        }
    }
    
}
