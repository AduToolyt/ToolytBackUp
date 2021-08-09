//
//  ForgotPassword.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

struct LoginConfirm {
    
    var userlat: String = ""
    var userlong: String = ""
    var userlocationName: String = ""
    var companyID: String = "16"
    var dummyAttendanceID : String = "590356"

    var companyId : String = ""
    var dummyAttandance : String = ""

    
    func validateData() -> (isValid: Bool, error: String) {
        var result = (isValid: true, error: "")
        
        if String.validateStringValue(str: userlat){
            result.isValid = false
            result.error = KUserLocation
            return result
        }
        if String.validateStringValue(str: userlong){
            result.isValid = false
            result.error = KUserLocation
            return result
        }
        return result
    }
    
    
    func paramDict() -> [String : Any]{
        var dict : [String : Any] = [:]
        if let dummyAttendance = _userDefault.object(forKey: "attandanceId") as? String{
            dict["dummy_attendance_id"] = dummyAttendance
        }
        dict["company_id"] = _user.companyId
        return dict
    }
    
    func paramAttendaceVerifyDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["latitude"] = userlat
        dict["longitude"] = userlong
        dict["location_name"] = userlocationName
        dict["company_id"] = companyID
        dict["dummy_attendance_id"] = dummyAttendanceID
        return dict
    }
}
