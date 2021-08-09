//
//  LeaderBoardModel.swift
//  Toolty
//
//  Created by Suraj on 22/07/21.
//

import Foundation
class LeaderBoardModel:NSObject{
    
    let status: Int
        var leaderList: [Leaderlist] = []
        var leadersCount: Int
        var currentPage: String
        var viewUserTeams: [ViewUserteam] = []
        var viewUserZones: [viewUserzones] = []
        var viewUserRegions: [ViewUserregion] = []
    
    init(dict: NSDictionary) {
        status = dict.getIntValue(key: "status")
        leadersCount = dict.getIntValue(key: "leadersCount")
        currentPage = dict.getStringValue(key: "currentPage")
        
        if let upcomingDict = dict["viewUserTeams"] as? [NSDictionary]{
            for dict in upcomingDict{
                let objData = ViewUserteam(dict: dict)
                self.viewUserTeams.append(objData)
            }
        }

        if let upcomingDict = dict["viewUserZones"] as? [NSDictionary]{
            for dict in upcomingDict{
                let objData = viewUserzones(dict: dict)
                self.viewUserZones.append(objData)
            }
        }
        
        if let upcomingDict = dict["viewUserRegions"] as? [NSDictionary]{
            for dict in upcomingDict{
                let objData = ViewUserregion(dict: dict)
                self.viewUserRegions.append(objData)
            }
        }
        if let upcomingDict = dict["leaderList"] as? [NSDictionary]{
            for dict in upcomingDict{
                let objData = Leaderlist(dict: dict)
                self.leaderList.append(objData)
            }
        }
    }
    
}
class Leaderlist:NSObject{
    var name, point, profile_pic, category_name: String
    var id: Int
    init(dict: NSDictionary) {
        name = dict.getStringValue(key: "name")
        point = dict.getStringValue(key: "point")
        profile_pic = dict.getStringValue(key: "profile_pic")
        category_name = dict.getStringValue(key: "category_name")
        id = dict.getIntValue(key: "id")
    }
}

class viewUserzones: NSObject {
    var id: Int
       var zoneName: String
       var teamID: Int
    
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        zoneName = dict.getStringValue(key: "zoneName")
        teamID = dict.getIntValue(key: "teamID")
    }
}

class ViewUserteam:NSObject{
    var id: Int
        var teamName: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        teamName = dict.getStringValue(key: "teamName")
    }
}

class ViewUserregion:NSObject{
    var id: Int
        var regionName: String
        var zoneID: Int
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        regionName = dict.getStringValue(key: "regionName")
        zoneID = dict.getIntValue(key: "zoneID")
    }
}


