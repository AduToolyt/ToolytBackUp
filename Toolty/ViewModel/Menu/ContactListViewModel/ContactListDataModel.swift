//
//  ContactListDataModel.swift
//  Toolty
//
//  Created by Nizamudheen on 06/08/21.
//

import Foundation
import UIKit

class ContactListDataModel: NSObject {
    var contactCount : Int = 0
    var contactModel : ContactListModel!
    var contacts : [Contacts] = []
    var currentPage : Int = 0
    var searchString : String = ""
    func paramContactsList() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        
        dict["search_word"] = searchString
        dict["no_of_data"] = 20
        dict["page_number"] = currentPage
        return dict
    }

}


//MARK:- Reschedual API WEB Call METHODS
extension ContactListDataModel{
    func getContactList(completion : @escaping ((ResponseType,[Contacts]) -> ())){
        KPWebCall.call.getContactList(param: paramContactsList()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200, let result = dictData["contacts"] as? [NSDictionary]{
                weakSelf.contactCount = (dictData["totalCount"] as? Int)!
                for data in result{
                    let obj = Contacts(dict: data)
                    weakSelf.contacts.append(obj)
                    debugPrint("sssssss ::: Results ::: \(data)")
                }
                completion(.success,weakSelf.contacts)
            }else{
                completion(.error, [])
            }
        }
    }

}
