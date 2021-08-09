//
//  Assign.swift
//  Toolty
//
//  Created by Chirag Patel on 26/07/21.
//

import Foundation
import UIKit

enum EnumChangeView{
    case assign
    case along
    
    init(val: Int) {
        if val == 0 {
            self = .assign
        }else{
            self = .along
        }
    }
}


class AlongData {
    var names : String
    var value : String
    var isSelected : Bool = false
    var variableName : String = ""
    init(name : String, id : String) {
        self.names = name
        self.value = id
    }
}


class Values{
    var names : String
    var id : String
    var manageFormId : String
    var variableName : String
    
    
    var arrNameStr : [String]{
        return names.components(separatedBy: [","])
    }
    
    var arrValueStr : [String]{
        return id.components(separatedBy: [","])
    }
    
    init(name : String, id : String, manageId : String, varName: String) {
        self.names = name
        self.id = id
        self.manageFormId = manageId
        self.variableName = varName
    }
}

class Assign{
    var manage_form_id : String
    var related_id: String
    var id : String
    var company_id : String
    var form_type : String
    var custom_static : String
    var status : Int
    var form_order : Int
    var comparison_operator : Int
    var comparison_value : Int
    var value : String
    var value_id : String
    var originalValue : String
    var single_line_status : String
    var form_customised : String
    var module_customised : String
    var customised_name : String
    var variable_name : String
    var inputType : Int
    var minValue : Int
    var validation_status : Int
    var validation_url : String
    var pickerStatusFlag : Int
    var waterMarkTimestampFlag : Int
    var add_status : Int
    var edit_status : Int
    var status_tab_status : Int
    var profile_tab_status : Int
    var field_name : String
    var field_type : Int
    var main_field_type : Int
    var not_comparison_value : Int
    var default_value : String
    
    init(dict: NSDictionary) {
        manage_form_id = dict.getStringValue(key: "manage_form_id")
        related_id = dict.getStringValue(key: "related_id")
        id = dict.getStringValue(key: "id")
        company_id = dict.getStringValue(key: "company_id")
        form_type  = dict.getStringValue(key: "form_type")
        custom_static = dict.getStringValue(key: "custom_static")
        status = dict.getIntValue(key: "status")
        form_order = dict.getIntValue(key: "form_order")
        comparison_operator = dict.getIntValue(key: "comparison_operator")
        comparison_value = dict.getIntValue(key: "comparison_value")
        value = dict.getStringValue(key: "value")
        value_id = dict.getStringValue(key: "value_id")
        originalValue = dict.getStringValue(key: "originalValue")
        single_line_status = dict.getStringValue(key: "single_line_status")
        form_customised = dict.getStringValue(key: "form_customised")
        module_customised = dict.getStringValue(key: "module_customised")
        customised_name = dict.getStringValue(key: "customised_name")
        variable_name = dict.getStringValue(key: "variable_name")
        inputType = dict.getIntValue(key: "inputType")
        minValue = dict.getIntValue(key: "minValue")
        validation_status = dict.getIntValue(key: "validation_status")
        validation_url = dict.getStringValue(key: "validation_url")
        pickerStatusFlag = dict.getIntValue(key: "pickerStatusFlag")
        waterMarkTimestampFlag = dict.getIntValue(key: "waterMarkTimestampFlag")
        add_status = dict.getIntValue(key: "add_status")
        edit_status = dict.getIntValue(key: "edit_status")
        status_tab_status = dict.getIntValue(key: "status_tab_status")
        profile_tab_status = dict.getIntValue(key: "profile_tab_status")
        field_name = dict.getStringValue(key: "field_name")
        field_type = dict.getIntValue(key: "field_type")
        main_field_type = dict.getIntValue(key: "main_field_type")
        not_comparison_value = dict.getIntValue(key: "not_comparison_value")
        default_value = dict.getStringValue(key: "default_value")
    }
}
