//
//  BillTableViewCell.swift
//  Toolty
//
//  Created by Suraj on 05/08/21.
//

import UIKit

class BillTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var purposetypeLbl: UILabel!
    @IBOutlet weak var expenseStatus:UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
