//
//  LanguageTableViewCell.swift
//  Toolty
//
//  Created by Nizamudheen on 28/07/21.
//

import Foundation

class LangaugeTableCell: UITableViewCell {
   
    @IBOutlet weak var imgTick : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    
    @IBOutlet weak var imgWidthConstraint: NSLayoutConstraint!
    func prepareLanguageCell(language : String,id : String){
        lblTitle.text = language
        if _userDefault.object(forKey: ToolytSelectedLang) as! String == id{
            imgWidthConstraint.constant = 25
            imgTick?.image = UIImage(named: "tick.png")
            
        }else{
            imgWidthConstraint.constant = 0
        }
        
        
    }

}
