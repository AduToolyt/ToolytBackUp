//
//  AddMenuCollCell.swift
//  Toolty
//
//  Created by Chirag Patel on 14/07/21.
//

import UIKit
import Kingfisher

class AddMenuCollCell: UICollectionViewCell {
    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    
    
    func prepareMenuCell(data: AddMenu){
        imgIcon.tintColor = #colorLiteral(red: 0.1411764706, green: 0.2980392157, blue: 0.631372549, alpha: 1)
        if data.iconName != ""{
            imgIcon.kf.setImage(with: data.iconUrl)
        }
        imgIcon.image = UIImage(named: data.imgName)
        lblTitle.text = data.menuName
    }
}
