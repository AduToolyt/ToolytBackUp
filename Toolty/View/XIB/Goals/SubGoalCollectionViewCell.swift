//
//  SubGoalCollectionViewCell.swift
//  Toolty
//
//  Created by Suraj on 26/07/21.
//

import UIKit
import CircleProgressBar
class SubGoalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cirProgressBar: CircleProgressBar!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var valuesLbl:UILabel!
    var objData : GoalModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cirProgressBar.hintTextFont = UIFont.systemFont(ofSize: 12)
    }

}
