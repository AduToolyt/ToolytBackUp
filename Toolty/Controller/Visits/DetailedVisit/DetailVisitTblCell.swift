//
//  DetailVisitTblCell.swift
//  Toolty
//
//  Created by Chirag Patel on 22/07/21.
//

import UIKit

class DetailVisitTblCell: UITableViewCell {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblSubTitle : UILabel!
    @IBOutlet weak var imgView : UIImageView!
    
    
    func prepareCell(data: VisitDetails){
        lblTitle.text = data.field_name
        if data.isImage {
            imgView.kf.setImage(with: URL(string: data.fieldValue))
        } else {
            lblSubTitle.text = data.fieldValue
        }
    }
}
