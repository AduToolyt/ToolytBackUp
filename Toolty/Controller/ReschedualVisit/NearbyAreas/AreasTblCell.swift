//
//  AreasTblCell.swift
//  Toolty
//
//  Created by Chirag Patel on 28/07/21.
//

import UIKit

class AreasTblCell: UITableViewCell {
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblLocalityName : UILabel!
    @IBOutlet weak var lblAddress : UILabel!
    
    func prepareCell(data: NearPlaces){
        imgView.kf.setImage(with: data.iconUrl)
        lblLocalityName.text = data.name
        lblAddress.text = data.detailedAddress
    }

}
