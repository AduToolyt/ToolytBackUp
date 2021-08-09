//
//  HomeCollCell.swift
//  Toolty
//
//  Created by Devang Lakhani  on 7/8/21.
//

import UIKit

class HomeCollCell: UICollectionViewCell {
    @IBOutlet weak var lblMenuTitle : UILabel!
    @IBOutlet weak var imgMenu : UIImageView!
    
    var arra = ["today","insight","leadership","goal"]

    func prepareMenu(data: MenuList){
        lblMenuTitle.text = data.name
    }
    func prepareImg(int:IndexPath){
        let unf = IndexPath(item: int.item, section: int.section)
        imgMenu.image = UIImage(named: arra[unf.item])
    }
}
