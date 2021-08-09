//
//  OtherVisitDetailVC.swift
//  Toolty
//
//  Created by Chirag Patel on 22/07/21.
//

import UIKit

class OtherVisitDetailVC: ParentViewController {
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var lblFullName : UILabel!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblCompanyName : UILabel!
    @IBOutlet weak var lblAddress : UILabel!
    @IBOutlet weak var imgDate : UIImageView!
    @IBOutlet weak var imgTime : UIImageView!
    @IBOutlet weak var imgFullName : UIImageView!
    @IBOutlet weak var imgUserName : UIImageView!
    @IBOutlet weak var imgCompanyName : UIImageView!
    @IBOutlet weak var imgAddress : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblLeadStatus : UILabel!
    @IBOutlet weak var locationView : UIView!
    
    var objVisit : Visit!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
}

//MARK:- Prepare Data
extension OtherVisitDetailVC{
    func prepareData(){
        locationView.isHidden = objVisit.address == "" ? true : false
        lblLeadStatus.text = objVisit.leadStatus
        lblTitle.text = objVisit.visitContent
        lblDate.text = objVisit.scheduleDate
        lblTime.text = convertFormat(time: objVisit.scheduleTime)
        lblFullName.text = _user.name
        lblUserName.text = _user.userName
        lblCompanyName.text = objVisit.companyName
        lblAddress.text = objVisit.address
        imgDate.image = UIImage(named: "ic_visit")
        imgTime.image = UIImage(named: "ic_visit")
        imgFullName.image = UIImage(named: "ic_visit")
        imgUserName.image = UIImage(named: "user-24")
        imgCompanyName.image = UIImage(named: "user-24")
        imgAddress.image = UIImage(named: "place-marker-24")
    }
}
