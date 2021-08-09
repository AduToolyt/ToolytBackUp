//
//  AccountMenu.swift
//  Toolty
//
//  Created by Chirag Patel on 20/07/21.
//

import Foundation
import UIKit

class AccountMenu{
    var title : String
    var imgName : String
    
    
    init(title: String,img : String) {
        self.title = title
        self.imgName = img
    }
}

class MenuItems{
    var title : String
    var imgName : String
    var id : Int32
    var urlLink : String?
    
    
    init(title: String, img : String, id : Int32, url : String?) {
        self.title = title
        self.imgName = img
        self.id = id
        self.urlLink = url
    }
}


struct feedArray{
    var id:String
    var name:String
}
