//
//  AddMenu.swift
//  Toolty
//
//  Created by Chirag Patel on 14/07/21.
//

import Foundation
import UIKit


class AddMenu {
    let id : String
    var menuName : String
    var link : String
    var iconName : String
    var showIn : String
    var imgName : String = ""
    
    var linkUrl : URL?{
        return URL(string: link)
    }
    
    var iconUrl : URL?{
        return URL(string: _storageUrl+iconName)
    }
    
    init(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        menuName = dict.getStringValue(key: "menu_name")
        link = dict.getStringValue(key: "link")
        iconName = dict.getStringValue(key: "icon_url")
        showIn = dict.getStringValue(key: "show_in")
        imgName = dict.getStringValue(key: "imgName")
    }
}

struct Menu : Codable {
    var id: Int
    var menu_name: String
    var link: String
    var icon_url: String
    var show_in: Int
}
