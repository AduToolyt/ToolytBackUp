//
//  RecordingView.swift
//  Simpilli
//
//  Created by Hitesh Khunt on 23/01/21.
//  Copyright © 2021 Hitesh Khunt. All rights reserved.
//

import UIKit

class RecordingView: UIView {

    @IBOutlet weak var imgView: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = 5.0
        loadGif()
    }
    
    class func initRecordingView(with view: UIView) -> RecordingView {
        let obj = Bundle.main.loadNibNamed("RecordingView", owner: self, options: nil)?.first as! RecordingView
        view.addSubview(obj)
        obj.addConstraintToSuperView(lead: 0, trail: 0, top: 0, bottom: 0)
        obj.layoutIfNeeded()
        obj.animateIn()
        return obj
    }
    
    func loadGif() {
        let url = Bundle.main.url(forResource: "voice_loaderrr", withExtension: "gif")!
        imgView.kf.setImage(with: url)
    }
    
    func animateIn() {
        alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        }) { (success) in
            
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { (success) in
            self.removeFromSuperview()
        }
    }
}
