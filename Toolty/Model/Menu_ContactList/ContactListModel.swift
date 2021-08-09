//
//  ContactListModel.swift
//  Toolty
//
//  Created by Nizamudheen on 06/08/21.
//
/*
 {"status":1,"totalCount":62,"contacts":[{"customer_id":2674689,"contact_id":2811538,"name":"Dr.Vaibhav","phone":"9544399455","email":"","is_favourite":0,"prefix":""},{"customer_id":2752843,"contact_id":2901901,"name":"Driver","phone":"955955555555","email":"a@gmail.com","is_favourite":0,"prefix":""}
 */
import Foundation

class ContactListModel{
    var status : Int
    var totalCount : Int
    var contacts : [Contacts] = []
    
    init(dict: NSDictionary) {
        status = dict.getIntValue(key: "status")
        totalCount = dict.getIntValue(key: "totalCount")
        
        if let dictPending = dict["contacts"] as? [NSDictionary]{
            for dictData in dictPending{
                let objData = Contacts(dict: dictData)
                self.contacts.append(objData)
            }
        }
                
    }
}


class Contacts{
    var customer_id : Int
    var contact_id : Int
    var name : String
    var email : String
    var phone : String
    var is_favourite : Bool
    var prefix : String
    
    init(dict: NSDictionary) {
        customer_id = dict.getIntValue(key: "customer_id")
        contact_id = dict.getIntValue(key: "contact_id")
        name = dict.getStringValue(key: "name")
        email = dict.getStringValue(key: "email")
        phone = dict.getStringValue(key: "phone")
        is_favourite = dict.getBooleanValue(key: "is_favourite")
        prefix = dict.getStringValue(key: "prefix")
    }
    
}
