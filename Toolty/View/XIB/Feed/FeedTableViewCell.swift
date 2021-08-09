//
//  FeedTableViewCell.swift
//  Toolty
//
//  Created by Suraj on 07/08/21.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var datetimeLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func type(_ id:Int) -> String{
        var str = String()
        if id == 2{
            str = "Customers"
        }else if id == 3{
            str = "Lead"
        }else if id == 5{
            str = "Order"
        }else if id == 6{
            str = "Expense"
        }else if id == 7{
            str = "Task"
        }else if id == 8 {
            str = "Visit"
        }else if id == 10{
            str = "Attendance"
        }else if id == 11{
            str = "Opportunity"
        }else if id == 12{
            str = "Jobs"
        }else if id == 13{
            str = "Leave"
        }else if id == 14{
            str = "Approval"
        }
        return str
    }
}
