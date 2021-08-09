//
//  User.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import Foundation
import CoreData

class User: NSManagedObject, ParentManagedObject {
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var deviceId: String
    @NSManaged var apiKey : String
    @NSManaged var catId : String
    @NSManaged var color : String
    @NSManaged var companyId : String
    @NSManaged var email: String
    @NSManaged var exitEnableStatus : String
    @NSManaged var forceLogoutStatus : String
    @NSManaged var obBoardingEnable : String
    @NSManaged var phone : String
    @NSManaged var froceLogoutFromStatus : String
    @NSManaged var picUrl : String
    @NSManaged var picName : String
    @NSManaged var storeEnableStatus : String
    @NSManaged var storeLocationDistance : String
    @NSManaged var storeLocation : String
    @NSManaged var userAccessType : String
    @NSManaged var userRefId : String
    @NSManaged var userStatus : String
    @NSManaged var userName : String
    
    
    var imgUrl : URL?{
        return URL(string: picUrl)
    }
    
    
    
    func initWith(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        name = dict.getStringValue(key: "user_name")
        email = dict.getStringValue(key: "email")
        deviceId = dict.getStringValue(key: "device_id")
        apiKey = dict.getStringValue(key: "api_key")
        catId = dict.getStringValue(key: "category_id")
        color = dict.getStringValue(key: "color")
        companyId = dict.getStringValue(key: "company_id")
        exitEnableStatus = dict.getStringValue(key: "exit_enable_status")
        forceLogoutStatus = dict.getStringValue(key: "force_logout_status")
        froceLogoutFromStatus = dict.getStringValue(key: "logout_form_status")
        obBoardingEnable = dict.getStringValue(key: "onboarding_enable")
        phone = dict.getStringValue(key: "phone")
        picUrl = dict.getStringValue(key: "picUrl")
        picName = dict.getStringValue(key: "profile_pic")
        storeEnableStatus = dict.getStringValue(key: "store_enable_status")
        storeLocationDistance = dict.getStringValue(key: "store_location_distance")
        storeLocation = dict.getStringValue(key: "store_or_location")
        userAccessType = dict.getStringValue(key: "user_access_type")
        userRefId = dict.getStringValue(key: "user_reference_id")
        userStatus = dict.getStringValue(key: "user_status")
        userName = dict.getStringValue(key: "username")
    }
}
