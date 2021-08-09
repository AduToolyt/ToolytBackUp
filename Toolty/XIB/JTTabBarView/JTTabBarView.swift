//
//  JTTabBarView.swift
//  EasyMed_Pharmacy
//
//  Created by Chirag Patel on 06/07/20.
//  Copyright © 2020 Chirag Patel. All rights reserved.
//

import UIKit

class JTTabBarView: ConstrainedView {

    @IBOutlet var btns: [UIButton]!
    @IBOutlet var lbls: [UILabel]!

    var selectedBlock: (Int) ->Void = {_  in}
    
    class func instantiateView() -> JTTabBarView {
        let objView = UINib(nibName: "JTTabBar", bundle: nil).instantiate(withOwner: self, options: nil).first as! JTTabBarView
        objView.frame = CGRect(x: 0, y: (_screenSize.height - 60.widthRatio) - _bottomAreaSpacing, width: _screenSize.width, height: (58.widthRatio) + _bottomAreaSpacing)
        objView.layoutIfNeeded()
        return objView
    }
}

extension JTTabBarView {
    
    func getSelectedIndex(completion: @escaping(Int) -> ()) {
        self.selectedBlock = completion
    }
    
    func setSelectedIndex(ind: Int) {
        for(idx,btn) in btns.enumerated() {
            if idx == ind {
                btn.alpha = 1.0
                lbls[idx].alpha = 1.0
                lbls[idx].font = UIFont.EasyMedFontWith(.openSansSemibold, size: 15.widthRatio)
            } else {
                btn.alpha = 0.6
                lbls[idx].alpha = 0.6
                lbls[idx].font = UIFont.EasyMedFontWith(.openSansRegular, size: 15.widthRatio)
            }
        }
        selectedBlock(ind)
    }
}

extension JTTabBarView {
    
    @IBAction func btnTabChange(_ sender: UIButton) {
        setSelectedIndex(ind: sender.tag)
    }
}

