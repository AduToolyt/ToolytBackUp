//
//  ExpinsesModel.swift
//  Toolty
//
//  Created by Suraj on 05/08/21.
//

import Foundation


class ExpensesList:NSObject{
    var status: String
       var totalCount: Int
       var viewUsers: [ViewUserTeamViewUser] = []
       var expenses: [ViewUserTeamExpense] = []
       var purpose:[viewUserTeamPurpose] = []
        var payModes: [ViewUserTeamPayMode] = []
       var expenseSettings: ViewUserTeamExpenseSettings!
       var companyCurrencySymbol, totalSpent, approvedAmount, claimedAmount: String

    init(dict: NSDictionary) {
        status = dict.getStringValue(key: "status")
        totalCount = dict.getIntValue(key: "totalCount")
        companyCurrencySymbol = dict.getStringValue(key: "company_currency_symbol")
        totalSpent = dict.getStringValue(key: "total_spent")
        approvedAmount = dict.getStringValue(key: "approved_amount")
        claimedAmount = dict.getStringValue(key: "claimed_amount")
        if let expset = dict["expenseSettings"] as? NSDictionary{
            self.expenseSettings = ViewUserTeamExpenseSettings(dict: expset)
        }
        if let expens = dict["expenses"] as? [NSDictionary]{
            for dictData in expens{
                let objdata = ViewUserTeamExpense(dict: dictData)
                self.expenses.append(objdata)
            }
        }
        if let user = dict["viewUsers"] as? [NSDictionary]{
            for dictData in user{
                let objdata = ViewUserTeamViewUser(dict: dictData)
                self.viewUsers.append(objdata)
            }
        }
        if let paymode = dict["payModes"] as? [NSDictionary]{
            for dictData in paymode{
                let objdata = ViewUserTeamPayMode(dict: dictData)
                self.payModes.append(objdata)
            }
        }
        if let purpos = dict["purpose"] as? [NSDictionary]{
            for dictData in purpos{
                let objdata = viewUserTeamPurpose(dict: dictData)
                self.purpose.append(objdata)
            }
        }
    }
}
class ViewUserTeamExpenseSettings: NSObject {
    var expenseBillStatus, expenseMileageStatus: Int
    init(dict: NSDictionary) {
        expenseBillStatus = dict.getIntValue(key: "expense_bill_status")
        expenseMileageStatus = dict.getIntValue(key: "expense_mileage_status")
    }
}
class ViewUserTeamExpense: NSObject {
    var purposeType: String
    var amount: Int
    var payModeType, comment: String
    var approveStatus, claimStatus: Int
    var date, invoiceImage: String
    var expenseID: Int
    var invoiceImageURL: String?
    var purposeID, payModeID, type, bikeCar: Int
    var placeFrom,placeTo: String
    var distance: Double
    var roundTrip, userID, expenseApprove, baseFlag: Int
    var expenseStatus: Int
    init(dict: NSDictionary) {
        purposeType = dict.getStringValue(key: "purpose_type")
        amount = dict.getIntValue(key: "amount")
        payModeType = dict.getStringValue(key: "pay_mode_type")
        comment = dict.getStringValue(key: "comment")
        approveStatus = dict.getIntValue(key: "approve_status")
        claimStatus = dict.getIntValue(key: "claim_status")
        date = dict.getStringValue(key: "date")
        invoiceImage = dict.getStringValue(key: "invoice_image")
        expenseID = dict.getIntValue(key: "expense_id")
        invoiceImageURL = dict.getStringValue(key: "invoice_image_url")
        purposeID = dict.getIntValue(key: "purpose_id")
        payModeID = dict.getIntValue(key: "pay_mode_id")
        type = dict.getIntValue(key: "type")
        bikeCar = dict.getIntValue(key: "bike_car")
        placeFrom = dict.getStringValue(key: "place_from")
        placeTo = dict.getStringValue(key: "place_to")
        distance = dict.getDoubleValue(key: "distance")
        roundTrip = dict.getIntValue(key: "round_trip")
        userID = dict.getIntValue(key: "user_id")
        expenseApprove = dict.getIntValue(key: "expense_approve")
        baseFlag = dict.getIntValue(key: "baseFlag")
        expenseStatus = dict.getIntValue(key: "expense_status")
    }
}
class ViewUserTeamViewUser:NSObject{
    var id,levelID,userID:Int
    var firstName, lastName, userName: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        levelID = dict.getIntValue(key: "level_id")
        userID = dict.getIntValue(key: "user_id")
        firstName = dict.getStringValue(key: "first_name")
        lastName = dict.getStringValue(key: "last_name")
        userName = dict.getStringValue(key: "user_name")
    }
}
class ViewUserTeamPayMode: NSObject {
    var id, companyID: Int
    var payModeType: String
    var createdAt, updatedAt: String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        companyID = dict.getIntValue(key: "company_id")
        payModeType = dict.getStringValue(key: "pay_mode_type")
        createdAt = dict.getStringValue(key: "created_at")
        updatedAt = dict.getStringValue(key: "updated_at")
    }
}
class viewUserTeamPurpose:NSObject{
    var id, companyID: Int
    var payModeType: String
    var createdAt, updatedAt: String
    var purposeType:String
    init(dict: NSDictionary) {
        id = dict.getIntValue(key: "id")
        companyID = dict.getIntValue(key: "company_id")
        payModeType = dict.getStringValue(key: "pay_mode_type")
        createdAt = dict.getStringValue(key: "created_at")
        updatedAt = dict.getStringValue(key: "updated_at")
        purposeType = dict.getStringValue(key: "purpose_type")
    }
}
