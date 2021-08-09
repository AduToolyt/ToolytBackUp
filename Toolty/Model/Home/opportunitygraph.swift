//
//  opportunitygraph.swift
//  Toolty
//
//  Created by Suraj on 22/07/21.
//

import Foundation

class opportinyModel:NSObject{
    var graphName: String
    var oppCount:[OppCount] = []

    init(dict: NSDictionary) {
        graphName = dict.getStringValue(key: "graphName")
        if let upcomingDict = dict["OppCount"] as? [NSDictionary]{
            for dict in upcomingDict{
                let objData = OppCount(dict: dict)
                self.oppCount.append(objData)
            }
        }

    }
}

class OppCount: NSObject {
    var date: String
    var open, won, closed: Int
    
    init(dict: NSDictionary) {
    date = dict.getStringValue(key: "date")
        open = dict.getIntValue(key: "open")
        won = dict.getIntValue(key: "won")
        closed = dict.getIntValue(key: "closed")
    }
}
