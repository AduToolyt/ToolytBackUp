//
//  SignUp.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

struct SignUp {
    
    var fullName: String = ""
    var email: String = ""
    var password: String = ""
    
    func validateData() -> (isValid: Bool, error: String) {
        var result = (isValid: true, error: "")
        if String.validateStringValue(str: fullName){
            result.isValid = false
            result.error = kEnterName
            return result
        }
        if String.validateStringValue(str: email){
            result.isValid = false
            result.error = kEnterEmail
            return result
        }
        if !email.isValidEmailAddress() {
            result.isValid = false
            result.error = kInvalidEmail
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
        dict["full_name"] = fullName
        dict["email_address"] = email
        dict["password"] = password
        dict["model_version"] = "iPhone"
        dict["product_name"] = "iPhone11"
        dict["os_version"] = "13.0"
        dict["device_udid"] = _deviceId
        return dict
    }
}
