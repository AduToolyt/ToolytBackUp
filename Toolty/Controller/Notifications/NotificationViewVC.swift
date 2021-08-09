//
//  NotificationViewVC.swift
//  Toolty
//
//  Created by Chirag Patel on 16/07/21.
//

import UIKit

class NotificationViewVC: ParentViewController {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    var objData : NotificationList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
}
//MARK:- Set Data
extension NotificationViewVC{
    func prepareData(){
        lblTitle.text = objData.title
        lblDescription.text = objData.content
    }
}
