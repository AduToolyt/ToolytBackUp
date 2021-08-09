//
//  LeaderBoardTableViewCell.swift
//  Toolty
//
//  Created by Suraj on 23/07/21.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {

    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userdesc: UILabel!
    @IBOutlet weak var usercountLbl: UILabel!
    @IBOutlet weak var trophyImg: UIImageView!
    
    var imgUrl = _hostMode.baseUrl+"public/images/profile_pic/"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
