//
//  CustomTabBarView.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//
//

import UIKit

class CustomTabBarView: UIView {
    @IBOutlet var btnsMenu : [UIButton]!
    @IBOutlet var lblMenu : [UILabel]!
    @IBOutlet var imgMenu : [UIImageView]!
    
    
    var completion : ((_ index : Int) -> ()) = {_ in}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
    }
    
    class func getView() -> CustomTabBarView{
        let customTabBar = UINib(nibName: "CustomTabBarView", bundle: nil).instantiate(withOwner: self, options: nil).first as! CustomTabBarView
        customTabBar.frame = CGRect(x: 0, y: (_screenSize.height - 65) - _bottomAreaSpacing, width: _screenSize.width, height: 65 + _bottomAreaSpacing)
        customTabBar.layoutIfNeeded()
        customTabBar.selectedIndexTintColor(index: 0)
        return customTabBar
    }
    
    func getSelectedIndex(completion: @escaping(Int) -> ()){
        self.completion = completion
    }
    
    func selectedIndexTintColor(index: Int){
        for btn in btnsMenu{
            imgMenu[btn.tag].tintColor = btn.tag == index ? UIColor(red: 0.05, green: 0.31, blue: 0.59, alpha: 1.00) : .black
            lblMenu[btn.tag].textColor = btn.tag == index ? UIColor(red: 0.05, green: 0.31, blue: 0.59, alpha: 1.00) : .black
        }
    }
}


//MARK:- Button Action
extension CustomTabBarView{
    @IBAction func btnMenuTapped(_ sender: UIButton){
        self.selectedIndexTintColor(index: sender.tag)
        completion(sender.tag)
    }
}
