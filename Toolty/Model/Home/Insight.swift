//
//  Insight.swift
//  Toolty
//
//  Created by Suraj on 21/07/21.
//

import Foundation

class insightModel:NSObject{
    var imageBaseURL:String?
    var revenueGraphStatus: Int?
    var summary:[summ] = []
    
    init(dict: NSDictionary) {
        imageBaseURL = dict.getStringValue(key: "imageBaseURL")
        revenueGraphStatus = dict.getIntValue(key: "revenueGraphStatus")
        if let upcomingDict = dict["summary"] as? [NSDictionary]{
            for dict in upcomingDict{
                let objData = summ(dict: dict)
                self.summary.append(objData)
            }
        }
    }
}

class summ:NSObject{
    var name, update, icon: String?
    var value:String?
    
    init(dict:NSDictionary) {
        name = dict.getStringValue(key: "name")
        update = dict.getStringValue(key: "update")
        icon = dict.getStringValue(key: "icon")
        value = dict.getStringValue(key: "value")
    }
}

struct InsightModel: Codable {
    let summary: [Summary]
    let imageBaseURL: String?
    let userList: [UserListModel]
    let revenueGraphStatus: Int?
}

// MARK: - Summary
struct Summary: Codable {
    let value: Value
    let name, update, icon: String?
}


enum Value: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UserList
struct UserListModel: Codable {
    let id, userID: Int?
    let firstName, lastName, userName: String?
    let levelID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case userName = "user_name"
        case levelID = "level_id"
    }
}
