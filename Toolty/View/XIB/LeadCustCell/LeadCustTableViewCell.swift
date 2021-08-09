//
//  LeadCustTableViewCell.swift
//  Toolty
//
//  Created by Suraj on 31/07/21.
//

import UIKit

class LeadCustTableViewCell: UITableViewCell {

    @IBOutlet weak var imagevi: UIImageView!
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var fullnameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var view1:UIView!
    @IBOutlet weak var lbl1:UILabel!
    @IBOutlet weak var view2:UIView!
    @IBOutlet weak var lbl2:UILabel!
    @IBOutlet weak var view3:UIView!
    @IBOutlet weak var lbl3:UILabel!
    @IBOutlet weak var classficationImg:UIImageView!
    @IBOutlet weak var statusImg:UIImageView!
  
    var imgUrl = _hostMode.baseUrl+"public/images/customer_pic/"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setclassificationImg(int:Int){
        if int == 1{
            classficationImg.image = UIImage(named: "hot")
        }else if int == 2{
            classficationImg.image = UIImage(named: "warm")
        }else if int == 3{
            classficationImg.image = UIImage(named: "cold")
        }
    }
    
    
    func setview(int:Int,val:String){
        if int == 0 && val != ""{
            lbl1.isHidden = false
            view3.isHidden = true
            lbl2.isHidden = true
            lbl3.isHidden = true
        }else if int == 1{
            lbl2.isHidden = false
            lbl1.isHidden = true
            lbl3.isHidden = true
            view3.isHidden = true
        }else if int == 2{
            lbl3.isHidden = false
            lbl1.isHidden = true
            view1.isHidden = true
            lbl2.isHidden = true
        }
        if val == ""{
            lbl1.isHidden = true
            lbl2.isHidden = true
            lbl3.isHidden = true
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = true
        }
        lbl1.text = val
        lbl2.text = val
        lbl3.text = val
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
