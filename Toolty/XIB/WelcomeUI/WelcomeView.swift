//
//  WelcomeView.swift
//  Simpilli
//
//  Created by Jayesh Tejwani on 23/08/20.
//  Copyright © 2020 Hitesh Khunt. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    var completionBlock:(()->())?

    class func instantiateView(withView view: UIView) -> WelcomeView {
        let objView = UINib(nibName: "WelcomeView", bundle: nil).instantiate(withOwner: self, options: nil).first as! WelcomeView
        view.addSubview(objView)
        objView.frame = CGRect(x: 0, y: 0, width: _screenSize.width, height: _screenSize.height)
        objView.layoutIfNeeded()
        return objView
      }
}

extension WelcomeView {
    
    @IBAction func btnLetsGoTapped(_ sender: UIButton) {
        completionBlock?()
        self.removeFromSuperview()
    }
}
