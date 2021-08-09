//
//  Language.swift
//  Toolty
//
//  Created by Hitesh Khunt on 01/07/21.
//

import Foundation

struct Language {
    
    var langSelect: String = ""

    func validateData() -> (isValid: Bool, error: String) {
        var result = (isValid: true, error: "")
        if String.validateStringValue(str: langSelect){
            result.isValid = false
            result.error = kSelectLang
            return result
        }
        return result
    }
    
    func paramVersionDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["app_type_id"] = "2"
        dict["package_name"] = _bundleID
        return dict
    }
    
    func paramLangaugeDict() -> [String : Any]{
        var dict : [String: Any] = [:]
        dict["user_id"] = "27"
        dict["app_language"] = _userDefault.object(forKey: ToolytSelectedLang)
        return dict
    }

}
