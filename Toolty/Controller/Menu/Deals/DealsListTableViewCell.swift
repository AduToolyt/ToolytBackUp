//
//  ContactTableViewCell.swift
//  Toolty
//
//  Created by Nizamudheen on 06/08/21.
//

import Foundation
import Charts
class DealsListTableViewCell: UITableViewCell {
   
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblOrgnsn : UILabel!
    @IBOutlet weak var lblRef : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblStatus : UILabel!
    
    @IBOutlet weak var statusView : UIView!
    @IBOutlet weak var chartView : PieChartView!
    @IBOutlet weak var imgWidthConstraint: NSLayoutConstraint!
    
    override class func awakeFromNib() {
        
    }
    
    func prepareDealsListCell(deals : String){
        if let _ = statusView{
            self.statusView.layer.cornerRadius = self.statusView.frame.height / 2
            self.statusView.layer.masksToBounds = true
        }
//        if let _ = imgProfile{
//            imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
//            imgProfile.layer.masksToBounds = true
//        }
//        self.lblName.text = contact.name
//        self.lblPhone.text = contact.phone != "" ? "phone : \(contact.phone )" : ""
//
//        imgProfile.setImage(string: contact.name, color: .randoms, circular: true, stroke: false, textAttributes: nil)
//        if contact.is_favourite{
//            imgWidthConstraint.constant = 25
//        }else{
//            imgWidthConstraint.constant = 0
//        }
        
    }

}
