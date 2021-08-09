//
//  ContactTableViewCell.swift
//  Toolty
//
//  Created by Nizamudheen on 06/08/21.
//

import Foundation
class ContactTableViewCell: UITableViewCell {
   
    @IBOutlet weak var imgFavourite : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblPhone : UILabel!
    @IBOutlet weak var imgProfile : UIImageView!
    @IBOutlet weak var imgWidthConstraint: NSLayoutConstraint!
    
    override class func awakeFromNib() {
        
    }
    
    func prepareContactListCell(contact : Contacts){
        if let _ = imgProfile{
            imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
            imgProfile.layer.masksToBounds = true
        }
        self.lblName.text = contact.name
        self.lblPhone.text = contact.phone != "" ? "phone : \(contact.phone )" : ""
        
        imgProfile.setImage(string: contact.name, color: .randoms, circular: true, stroke: false, textAttributes: nil)
        if contact.is_favourite{
            imgWidthConstraint.constant = 25
        }else{
            imgWidthConstraint.constant = 0
        }
        
    }

}
