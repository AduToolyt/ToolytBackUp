//
//  MilageTableViewCell.swift
//  Toolty
//
//  Created by Suraj on 05/08/21.
//

import UIKit

class MilageTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var purposetypeLbl: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var expenseStatus:UILabel!
    @IBOutlet weak var distanceLbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
