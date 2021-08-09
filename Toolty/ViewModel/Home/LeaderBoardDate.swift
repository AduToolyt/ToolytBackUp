//
//  LeaderBoardDate.swift
//  Toolty
//
//  Created by Suraj on 22/07/21.
//

import Foundation
//LeaderBoardModel
class LeaderBoardDate: NSObject{
     var objHome : LeaderBoardModel!
        var Startdate = ""
        var Enddate = ""
        var userID = ""
    func paramDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["page_number"] = "1"
        dict["end_date"] = Enddate
        dict["start_date"] = Startdate
        dict["company_id"] = _user.companyId
        dict["user_id"] = userID
        dict["team_lead_id"] = _user.id
        dict["number_of_data"] = "10"
        return dict
    }
    
    
    
}
extension LeaderBoardDate{
    
    func getLeaderBoard(completion : @escaping (ResponseType, LeaderBoardModel?) -> ()){
        KPWebCall.call.homeLeaderboardData(param: paramDict()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                DispatchQueue.main.async {
                    print(dict)
                    weakSelf.objHome = LeaderBoardModel(dict: dict)
                    completion(.success,weakSelf.objHome)
                }
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
    
}
