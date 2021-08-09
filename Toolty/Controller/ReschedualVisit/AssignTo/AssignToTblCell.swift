//
//  AssignToTblCell.swift
//  Toolty
//
//  Created by Chirag Patel on 26/07/21.
//

import UIKit

class AssignToTblCell: UITableViewCell {
    @IBOutlet weak var lblName : UILabel!
    weak var parentVC : AssignToVC!

    func prepareCell(data: AlongData){
        if data.isSelected{
            lblName.textColor = #colorLiteral(red: 0.1411764706, green: 0.2980392157, blue: 0.631372549, alpha: 1)
        }else{
            lblName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
