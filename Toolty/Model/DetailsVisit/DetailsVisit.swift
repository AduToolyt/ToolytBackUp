//
//  DetailsVisit.swift
//  Toolty
//
//  Created by Chirag Patel on 22/07/21.
//

import Foundation
import UIKit

enum EnumStatusType{
    case yellow
    case green
    
    
    init(val: Int) {
        if val == 0{
            self = .yellow
        }else{
            self = .green
        }
    }
}

class VisitDetails{
    var id : String
    var manageId : Int
    var relatedId : Int
    var companyId : Int
    var formType : Int
    var customStatic : Int
    var status : Int
    var formOrder : Int
    var comparison_operator: Int
    var comparison_value: String
    var value: String
    var value_id : String
    var originalValue : String
    var single_line_status : Int
    var form_customised : Int
    var module_customised : Int
    var customised_name : String
    var variable_name : String
    var inputType : Int
    var minValue : Int
    var maxValue : Int
    var validation_status : Int
    var validation_url : String
    var pickerStatusFlag : Int
    var waterMarkTimestampFlag : Int
    var add_status  : Int
    var edit_status : Int
    var status_tab_status : Int
    var profile_tab_status : Int
    var field_name : String
    var field_type : Int
    var main_field_type : Int
    var not_comparison_value : String
    var default_value : String
    var fieldValue : String
    
    var isImage : Bool {
        return field_name == "Image" ? true : false
    }
    
    init(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        manageId = dict.getIntValue(key: "manage_form_id")
        relatedId = dict.getIntValue(key: "related_id")
        companyId = dict.getIntValue(key: "company_id")
        formType = dict.getIntValue(key: "form_type")
        customStatic = dict.getIntValue(key: "custom_static")
        status = dict.getIntValue(key: "status")
        formOrder = dict.getIntValue(key: "form_order")
        comparison_operator = dict.getIntValue(key: "comparison_operator")
        comparison_value = dict.getStringValue(key: "comparison_value")
        value = dict.getStringValue(key: "value")
        value_id = dict.getStringValue(key: "value_id")
        originalValue = dict.getStringValue(key: "originalValue")
        single_line_status = dict.getIntValue(key: "single_line_status")
        form_customised = dict.getIntValue(key: "form_customised")
        module_customised = dict.getIntValue(key: "module_customised")
        customised_name = dict.getStringValue(key: "customised_name")
        variable_name = dict.getStringValue(key: "variable_name")
        inputType = dict.getIntValue(key: "inputType")
        minValue = dict.getIntValue(key: "minValue")
        maxValue = dict.getIntValue(key: "maxValue")
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
        not_comparison_value = dict.getStringValue(key: "not_comparison_value")
        default_value = dict.getStringValue(key: "default_value")
        fieldValue = dict.getStringValue(key: "fieldValue")
        
    }
}
