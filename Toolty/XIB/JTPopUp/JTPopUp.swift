//
//  JTPopUp.swift
//  Presenta
//
//  Created by Hitesh Khunt on 26/08/20.
//  Copyright © 2020 Hitesh Khunt. All rights reserved.
//

import UIKit

class JTPopUp: ConstrainedView {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDeclinedReason: UILabel!
    @IBOutlet weak var lblDeclinTitle: UILabel!
    
    @IBOutlet weak var lblVersionNo: UILabel!
        
    var completionBlock:(()->())?

    class func initPopUp(with view: UIView, noti: PushNotification) -> JTPopUp {
        let obj = Bundle.main.loadNibNamed("JTPopUp", owner: self, options: nil)?.last as! JTPopUp
        view.addSubview(obj)
        obj.imgUser.kf.setImage(with: _user.profileUrl, placeholder: _placeImageUser)
        obj.lblName.text = _user.name
        obj.lblDate.text = Date.localDateString(from: noti.callDate, format: "E, MMM d, h:mm a")
        obj.lblDesc.text = noti.message
        
        obj.lblDeclinedReason.text = noti.status == "Completed" ? "" : noti.reason
        obj.lblDeclinTitle.text = noti.status == "Completed" ? "" : "Declined Reason"
            
        obj.addConstraintToSuperView(lead: 0, trail: 0, top: 0, bottom: 0)
        obj.layoutIfNeeded()
        obj.animateIn()
        return obj
    }
    
    class func initAddUpdatePopUp(with view: UIView, versionNo: String) -> JTPopUp {
        let obj = Bundle.main.loadNibNamed("JTPopUp", owner: self, options: nil)?.first as! JTPopUp
        view.addSubview(obj)
        obj.lblVersionNo.text = "v\(versionNo)"
        obj.addConstraintToSuperView(lead: 0, trail: 0, top: 0, bottom: 0)
        obj.layoutIfNeeded()
        obj.animateIn()
        return obj
    }
    
    func animateIn() {
        alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        }) { (success) in
            
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { (success) in
            self.removeFromSuperview()
        }
    }
}

extension JTPopUp {
    
    @IBAction func btnClose() {
        self.animateOut()
    }
    
    @IBAction func btnUpdate() {
        completionBlock?()
        self.animateOut()
    }
}
