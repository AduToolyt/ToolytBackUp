//
//  ExpensesData.swift
//  Toolty
//
//  Created by Suraj on 05/08/21.
//

import Foundation

class ExpensesData:NSObject{
    var objExpList : ExpensesList!
    var user = ""
    var pageNo = ""
    var statusType = ""
    var expenseType = ""
    var statusId = ""
    var formDate = ""
    var toDate = ""
    
    func ExpenseListPara()->[String:Any]{
        var dict : [String: Any] = [:]
        dict["company_id"] = _user.companyId
        dict["team_lead_id"] = _user.id
        dict["user_id"] = user
        dict["_token"] = ""
        dict["page_number"] = pageNo
        dict["status_id"] = statusId
        dict["expense_type"] = expenseType
        dict["from_date"] = formDate
        dict["to_date"] = toDate
        return dict
    }
    
}
extension ExpensesData{
    func getExpList(completion : @escaping (ResponseType, ExpensesList?) -> ()){
        KPWebCall.call.MenuExpensesList(param: ExpenseListPara()) {[weak self] (json, statusCode) in
            guard let weakSelf = self,let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                print(dict)
                weakSelf.objExpList = ExpensesList(dict: dict)
                completion(.success,weakSelf.objExpList)
                if let Created = dict["viewUsers"] as? [NSDictionary]{
                    for i in Created{
                        print(i)
                        _LeadViewUserList = LeadViewUserList.addUpdateEntity(key: "id", value: i.getStringValue(key: "id"))
                        _LeadViewUserList.initWith(dict: i)
                        _appDelegator.saveContext()
                    }
                }
            }else{
                JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error,nil)
            }
        }
    }
}
