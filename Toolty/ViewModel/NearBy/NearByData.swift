//
//  NearByData.swift
//  Toolty
//
//  Created by Suraj on 19/07/21.
//

import Foundation


class NearByData:NSObject{
    var objvisit : GetMapContentModel!
    
    var lati,longi: String?
    func GetmapparamDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["user_id"] = _user.id
        dict["longitude"] = lati!
        dict["latitude"] = longi!
        return dict
    }
}

extension NearByData{
    func getMapOptionOverview(completion : @escaping (ResponseType, GetMapContentModel?) -> ()){
        KPWebCall.call.mapoption(param: GetmapparamDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200 {
                weakSelf.objvisit = GetMapContentModel(dict: dict)
               
                completion(.success,weakSelf.objvisit)
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
}
