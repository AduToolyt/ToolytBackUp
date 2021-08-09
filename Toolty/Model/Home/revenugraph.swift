//
//  revenugraph.swift
//  Toolty
//
//  Created by Suraj on 22/07/21.
//

import Foundation

struct revenuChartModel: Codable {
    let currencySymbol, companyCurrency: String
    let revenue: [Revenue]
    let graphName: String
}

// MARK: - Revenue
struct Revenue: Codable {
    let date: String
    let revenue: Int
}

class RevenuchartModel:NSObject{
    var currencySymbol, companyCurrency,graphName: String
    var revenu:[RevenuData] = []
    init(dict: NSDictionary) {
        currencySymbol = dict.getStringValue(key: "currencySymbol")
        companyCurrency = dict.getStringValue(key: "companyCurrency")
        graphName = dict.getStringValue(key: "graphName")
        
        if let upcomingDict = dict["revenue"] as? [NSDictionary]{
            for dict in upcomingDict{
                let objData = RevenuData(dict: dict)
                self.revenu.append(objData)
            }
        }
    }
}
class RevenuData:NSObject{
    var date: String
    var revenu: Int
    init(dict: NSDictionary) {
        date = dict.getStringValue(key: "date")
        revenu = dict.getIntValue(key: "revenu")
    }
}
