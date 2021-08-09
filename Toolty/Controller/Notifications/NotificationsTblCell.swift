//
//  NotificationsTblCell.swift
//  Toolty
//
//  Created by Chirag Patel on 12/07/21.
//

import UIKit

class NotificationsTblCell: UITableViewCell {
    @IBOutlet weak var userView : UIView!
    @IBOutlet weak var lblViewText : UILabel!
    @IBOutlet weak var lblNotiTitle : UILabel!
    @IBOutlet weak var lblNotiDescription : UILabel!
    @IBOutlet weak var lblDateTime : UILabel!
    @IBOutlet weak var notiView : UIView!
    @IBOutlet weak var btnView : UIButton!
    
    weak var parentVC : NotificationsVC!
    
    func prepareNotificationCell(data: NotificationList){
        lblNotiTitle.text = data.title
        lblNotiDescription.text = data.content
        lblDateTime.text = data.dateTime
        notiView.isHidden = data.readStatus == 1 ? true : false
        userView.backgroundColor = UIColor.random()
        let wordArray = data.title.split(separator: " ")
        if wordArray.count >= 2 {
            let firstTwoChar = String(wordArray[0].first!)+String(wordArray[1].first!)
            lblViewText.text = firstTwoChar
            lblViewText.textColor = .white
        }
    }
}
