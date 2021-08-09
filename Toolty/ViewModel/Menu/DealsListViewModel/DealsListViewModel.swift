//
//  DealsListViewModel.swift
//  Toolty
//
//  Created by Nizamudheen on 07/08/21.
//

import Foundation

import UIKit

class DealsListViewModel: NSObject {
    var dealsCount : Int = 0
   var dealsTeamsModel : DealsTeamFilterModel!
    var deals : DealsListModel!
    var dealsList : [DealsOpportunities] = []
    var currentPage : Int = 0
    var searchString : String = ""
    
    var global_RegionId : String = ""
    var team_ids : String = ""
    var zone_ids : String = ""
    var take_all_users : Int = 0
    var stage : Int = 0
    var type : Int = 1
//    take_all_users
    
    func paramDealsGlobal() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        return dict
    }
    
    func paramDealsTeam() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        dict["global_region_ids"] = global_RegionId
        return dict
    }
    
    func paramDealsZones() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        dict["team_ids"] = team_ids
        return dict
    }
    
    func paramDealsRegion() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        dict["zone_ids"] = zone_ids
        return dict
    }
    
    func paramDealsUser() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        
        //global_region_ids=&filter_page=opportunities&team_ids=&zone_ids=
        dict["global_region_ids"] = global_RegionId
        dict["team_ids"] = team_ids
        dict["zone_ids"] = zone_ids
        dict["filter_page"] = "opportunities"
        return dict
    }
    
    func paramDealsList() -> [String : Any]{
        var dict : [String : Any] = [:]
        dict["user_id"] = _user.id
        dict["company_id"] = _user.companyId
        dict["search_word"] = searchString
        //&stage=0&page_number=0&type=1
        
        dict["team_lead_id"] = _user.id
        dict["take_all_users"] = take_all_users
        dict["stage"] = stage
        dict["page_number"] = currentPage
        dict["type"] = type
        
        return dict
    }

}


//MARK:- Reschedual API WEB Call METHODS
extension DealsListViewModel{
    func getGlobalregion(completion : @escaping ((ResponseType,[String?]) -> ())){
        KPWebCall.call.getGlobalregion(param: paramDealsGlobal()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200{
                debugPrint("sssssss ::: Results ::: \(dictData)")
                completion(.success,[])
            }else{
                completion(.error, [])
            }
        }
    }
    func getTeamsFilter(completion : @escaping ((ResponseType,DealsTeamFilterModel?) -> ())){
        KPWebCall.call.getTeamsFilter(param: paramDealsTeam()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200{
                weakSelf.dealsTeamsModel = DealsTeamFilterModel(dict: dictData)
                debugPrint("sssssss ::: Results ::: \(dictData)")
                completion(.success,weakSelf.dealsTeamsModel)
            }else{
                completion(.error, nil)
            }
        }
    }
    
    func getZoneFilter(completion : @escaping ((ResponseType,DealsTeamFilterModel?) -> ())){
        KPWebCall.call.getZoneFilter(param: paramDealsZones()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200{
                weakSelf.dealsTeamsModel = DealsTeamFilterModel(dict: dictData)
                debugPrint("sssssss ::: Results ::: \(dictData)")
                completion(.success,weakSelf.dealsTeamsModel)
            }else{
                completion(.error, nil)
            }
        }
    }
    
    func getRegionFilter(completion : @escaping ((ResponseType,DealsTeamFilterModel?) -> ())){
        KPWebCall.call.getRegionFilter(param: paramDealsRegion()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200{
                weakSelf.dealsTeamsModel = DealsTeamFilterModel(dict: dictData)
                debugPrint("sssssss ::: Results ::: \(dictData)")
                completion(.success,weakSelf.dealsTeamsModel)
            }else{
                completion(.error, nil)
            }
        }
    }
    
    func getUserFilter(completion : @escaping ((ResponseType,DealsTeamFilterModel?) -> ())){
        KPWebCall.call.getUserFilter(param: paramDealsUser()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200{
                weakSelf.dealsTeamsModel = DealsTeamFilterModel(dict: dictData)
                debugPrint("sssssss ::: Results ::: \(dictData)")
                completion(.success,weakSelf.dealsTeamsModel)
            }else{
                completion(.error, nil)
            }
        }
    }
    
    func getDeals(completion : @escaping ((ResponseType,DealsListModel?) -> ())){
        KPWebCall.call.getDealsList(param: paramDealsList()) {[weak self] (json, statusCode) in
            guard let dictData = json as? NSDictionary, let weakSelf = self else {return}
            if statusCode == 200{
                weakSelf.deals = DealsListModel(dict: dictData)
                weakSelf.dealsList = weakSelf.deals.opportunities
                debugPrint("sssssss ::: Results ::: \(dictData)")
                completion(.success,weakSelf.deals)
            }else{
                completion(.error, nil)
            }
        }
    }

}
