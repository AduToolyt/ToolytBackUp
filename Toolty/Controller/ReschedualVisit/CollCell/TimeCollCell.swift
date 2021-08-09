//
//  TimeCollCell.swift
//  Toolty
//
//  Created by Chirag Patel on 23/07/21.
//

import UIKit

class TimeCollCell: UICollectionViewCell {
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var view : UIView!
    
    func prepareCell(data: TimeSlots){
        if data.isSelected {
            view.backgroundColor = #colorLiteral(red: 0.2710604072, green: 0.6759784818, blue: 0.3441274166, alpha: 1)
            lblTime.textColor = .white
            lblTime.text = data.intervalTime
        }else{
            view.backgroundColor = .white
            lblTime.textColor = #colorLiteral(red: 0.1411764706, green: 0.2980392157, blue: 0.631372549, alpha: 1)
            lblTime.text = data.timeStr
        }
    }
}
