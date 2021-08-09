//
//  showmoreTableViewCell.swift
//  Toolty
//
//  Created by Suraj on 27/07/21.
//

import UIKit
import CircleProgressBar

class showmoreTableViewCell: UITableViewCell {
    @IBOutlet weak var cirProgressBar: CircleProgressBar!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var compLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cirProgressBar.hintTextFont = UIFont.systemFont(ofSize: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
