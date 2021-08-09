//
//  Login.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

struct Login {
    
    var userName: String = ""
    var password: String = ""
    var device_name: String = ""
    var total_internal_memory: String = ""
    var internet_speed: String = ""
    var company_id: String = "16"
    var fcm_id: String = ""
    var version_number: String = ""
    var device_memory: String = ""
    var device_id: String = ""
    var device_Type: String = "iOS"
    var attempt: String = "1"
    var device_timezone: String = getCurrentTimeZone()
    
    var device_battery : String{
        UIDevice.current.isBatteryMonitoringEnabled = true
        print("BATTERY : \(UIDevice.current.batteryLevel)")
        return "\((Int(UIDevice.current.batteryLevel * 100)))"
    }

        
    func validateData() -> (isValid: Bool, error: String) {
        var result = (isValid: true, error: "")
        
        if String.validateStringValue(str: userName){
            result.isValid = false
            result.error = kEnterUserName
            return result
        }
        if String.validateStringValue(str: password){
            result.isValid = false
            result.error = kEnterPassword
            return result
        }
        return result
    }
   
    func paramDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["user_name"] = userName
        dict["password"] = password
        dict["device_name"] = _deviceName
        dict["available_internal_memory"] = "\(DiskStatus.freeDiskSpaceInBytes)"
        dict["total_internal_memory"] = "\(DiskStatus.totalDiskSpace)"
        dict["internet_speed"] = internet_speed
        dict["company_id"] = company_id
        dict["device_battery"] = device_battery
        dict["fcm_id"] = _deviceId
        dict["version_number"] = _deviceVersion
        dict["device_memory"] = _deviceMemoryAvailable
        dict["device_id"] = _deviceId
        dict["device_model"] = _deviceModel
        dict["os_version"] = _deviceModel
        dict["user_timezone_app_offset"] = "\(Date().currentTimeMillis())"
        dict["ios_android"] = device_Type
        dict["attempt"] = attempt
        return dict
    }
    
    func paramVersionDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["app_type_id"] = "2"
        dict["package_name"] = _bundleID
        return dict
    }
}

class AppVersionData {
    var status : String = ""
    var packageName : String = ""
    var versionId : String = ""
    
    init(dict : NSDictionary) {
        status = dict.getStringValue(key: "status")
        packageName = dict.getStringValue(key: "package_name")
        versionId = dict.getStringValue(key: "version_id")
    }
    
}
