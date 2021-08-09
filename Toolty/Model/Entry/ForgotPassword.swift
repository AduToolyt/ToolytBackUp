//
//  ForgotPassword.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

struct ForgotPassword {
    
    var userName: String = ""
    var otp: String = ""
    var companyID: String = "16"
    var compId : String = ""
    var leadId : String = ""
    var userID: String = ""
    
    
    func validateData() -> (isValid: Bool, error: String) {
        var result = (isValid: true, error: "")
        
        if String.validateStringValue(str: userName){
            result.isValid = false
            result.error = kEnterUserName
            return result
        }
        return result
    }
    
    func paramDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["user_value"] = userName
        return dict
    }
    
    func paramGetOTPDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["otp"] = otp
        dict["companyId"] = companyID
        dict["userId"] = userName
        return dict
    }
    
    func paramChangePassword() -> [String : Any]{
        var dict: [String: Any] = [:]
        dict["team_lead_id"] = leadId
        dict["company_id"] = compId
        dict["new_password"] = userName
        return dict
    }
}

class Otp{
    var otp: String = ""
    
    func validateData() -> (isValid: Bool, error: String) {
        var result = (isValid: true, error: "")
        
        if String.validateStringValue(str: otp){
            result.isValid = false
            result.error = kEnterUserName
            return result
        }
        return result
    }
}
