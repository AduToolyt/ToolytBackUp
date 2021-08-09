//
//  OnBoardCollCell.swift
//  Toolty
//
//  Created by Hitesh Khunt on 06/07/21.
//

import UIKit

class OnBoardCollCell: ConstrainedCollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var viewPermission: UIView!
    @IBOutlet weak var btnPermission: UIButton!

    weak var parent : OnBoardingVC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension OnBoardCollCell {
    
    func prepareOnboardCell(indexPath:Int) {
        if indexPath == 0 {
            lblTitle.text = "LocationPermissionTxt".localized()
            lblSubTitle.text = "LocationPermissionMessageTxt".localized()
            let btnText = "LocationAllowNext".localized()
            btnPermission.setTitle("\(btnText)", for: .normal)
            if parent.locationPermission == true {
                btnPermission.isEnabled = false
                btnPermission.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            } else  {
                btnPermission.isEnabled = true
            }
        } else {
            lblTitle.text = "lbLNotiPermissionTxt".localized()
            lblSubTitle.text = "NotifPermissionMsgTxt".localized()
            let btnText = "AllowNotificationTxt".localized()
            btnPermission.setTitle("\(btnText)", for: .normal)
        }
        viewPermission.layer.cornerRadius = 10
        btnPermission.layer.cornerRadius = btnPermission.frame.height / 2
    }

}
