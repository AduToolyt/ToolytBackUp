//
//  ForgotPasswordData.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

class ForgotPasswordData {
    
    var forgotPassword: ForgotPassword!
    var otp : Int = 0
    var compId : Int = 0
    var userId : Int = 0
    var forgotCells: [ForgotCells] = []
    
    init() {
        forgotPassword = ForgotPassword()
        forgotCells = [.fieldCell, .buttonCell]
    }
    
    enum ForgotCells {
        case fieldCell
        case buttonCell
        
        var cellId: String {
            switch self {
            case .fieldCell:
                return "fieldCell"
            case .buttonCell:
                return "buttonCell"
            }
        }
        
        var cellHeight: CGFloat {
            switch self {
            case .fieldCell:
                return 80.widthRatio
            default:
                return 64.widthRatio
            }
        }
    }
}

extension ForgotPasswordData {
    
    func recoverPassword(completion: @escaping(ResponseType,Int,Int,Int) -> ()) {
        KPWebCall.call.forgotPassword(param: forgotPassword.paramDict()) {[unowned self] (json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200 {
                if let otps = dict["otp"] as? Int, let companyId = dict["companyId"] as? Int, let leadId = dict["userId"] as? Int{
                    self.otp = otps
                    self.compId = companyId
                    self.userId = leadId
                }
                completion(.success, self.otp, self.compId,self.userId)
            } else {
                JTValidationToast.show(message: dict.getStringValue(key: "response"))
                completion(.error, 0,0,0)
            }
        }
    }
    
    func changeNewPassword(completion: @escaping(ResponseType) -> ()){
        KPWebCall.call.resetPassword(param: forgotPassword.paramChangePassword()) {(json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200 {
                JTValidationToast.show(message: dict.getStringValue(key: "message"))
                completion(.success)
            } else {
                JTValidationToast.show(message: dict.getStringValue(key: "message"))
                completion(.error)
            }
        }
    }
}
