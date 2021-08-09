//
//  ManageCollCell.swift
//  Toolty
//
//  Created by Devang Lakhani  on 7/8/21.
//

import UIKit

class ManageCollCell: UICollectionViewCell {
    @IBOutlet weak var lblCount : UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var backView : UIView!
    @IBOutlet weak var imgCustView : UIImageView!
    @IBOutlet weak var lblCompanyName : UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    func preparePendingCell(data: Pending, type: EnumHome, getIndexPathColor:Int){
        backView.backgroundColor = UIColor(hexaRGBA: arrColors[getIndexPathColor])
        lblCount.text = "\(data.count)"
        lblTitle.text = data.title
    }
    
    func prepareMissingActivityCell(data: Schedules, type: EnumHome){
        lblCompanyName.text = data.customerName
        lblDate.text = data.strDate
    }
}
