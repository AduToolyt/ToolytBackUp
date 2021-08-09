//
//  FeedData.swift
//  Toolty
//
//  Created by Suraj on 07/08/21.
//

import Foundation
class FeedData:NSObject{
    var objFeed : FeedModel!
    var page = ""
    var user = ""
    var contetntType = ""
    func FeedListPara()->[String:Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        dict["user_id"] = user
        dict["page_number"] = page
        dict["content_type_filter"] = contetntType
        return dict
    }
}
extension FeedData{
    func getFeedList(completion : @escaping (ResponseType, FeedModel?) -> ()){
        KPWebCall.call.MenuFeedReq(param: FeedListPara()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                print(dict)
                weakSelf.objFeed = FeedModel(dict: dict)
                completion(.success,weakSelf.objFeed)
                if let Created = dict["viewUsers"] as? [NSDictionary]{
                    for i in Created{
                        print(i)
                        _LeadViewUserList = LeadViewUserList.addUpdateEntity(key: "id", value: i.getStringValue(key: "id"))
                        _LeadViewUserList.initWith(dict: i)
                        _appDelegator.saveContext()
                    }
                }
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
}
