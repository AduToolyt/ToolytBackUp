//
//  LeaveTableViewCell.swift
//  Toolty
//
//  Created by Suraj on 06/08/21.
//

import UIKit

class LeaveTableViewCell: UITableViewCell {
    @IBOutlet weak var approvalview: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var masterleavepolicy: UILabel!
    @IBOutlet weak var daterange: UILabel!
    @IBOutlet weak var daysCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getApproved(_ int:Int){
        switch int{
        case 0:
            approvalview.backgroundColor = UIColor(named: "yellow_c")
        case 1:
            approvalview.backgroundColor = UIColor(named: "green_c")
        case 2:
            approvalview.backgroundColor = UIColor(named: "red_c")
        default:
            print("Nothing")
        }
    }
    
    
}
