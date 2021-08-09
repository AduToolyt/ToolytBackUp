//
//  UIViewControllerExtension.swift
//  Toolty
//
//  Created by Nizamudheen on 04/08/21.
//

import Foundation
import ContactsUI
class ParentUIController : UIViewController{
    
    
    var actInd:UIActivityIndicatorView!
    var blurEffectView = UIView()
    let refresh = UIRefreshControl()
    override func viewDidLoad() {
        actInd = UIActivityIndicatorView(style:UIActivityIndicatorView.Style.large)
        actInd.color = .white
        actInd.center = view.center;
    }
    
    func showActivityHud() -> () {
        
        blurEffectView.frame = .init(x: 0, y: 0, width: 80, height: 80)
        blurEffectView.center = view.center
        blurEffectView.backgroundColor = UIColor(white:0, alpha:0.6)
        blurEffectView.layer.cornerRadius = 5
        self.blurEffectView.alpha = 1
        view.addSubview(blurEffectView)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        blurEffectView.addSubview(actInd)
        actInd.frame.origin = CGPoint(x:(blurEffectView.frame.width / 2) - (actInd.frame.width / 2) , y: (blurEffectView.frame.height / 2) - (actInd.frame.height / 2))
        actInd.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideActivityHud() -> (){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIView.animate(withDuration:0.2, animations: {
                self.blurEffectView.alpha = 0
            }, completion: { (done) in
                self.actInd.stopAnimating()
                self.blurEffectView.removeFromSuperview()
            })
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

class ParentCNViewController : CNContactViewController{
    
    
    var actInd:UIActivityIndicatorView!
    var blurEffectView = UIView()
    let refresh = UIRefreshControl()
    override func viewDidLoad() {
        actInd = UIActivityIndicatorView(style:UIActivityIndicatorView.Style.large)
        actInd.color = .white
        actInd.center = view.center;
    }
    
    func showActivityHud() -> () {
        
        blurEffectView.frame = .init(x: 0, y: 0, width: 80, height: 80)
        blurEffectView.center = view.center
        blurEffectView.backgroundColor = UIColor(white:0, alpha:0.6)
        blurEffectView.layer.cornerRadius = 5
        self.blurEffectView.alpha = 1
        view.addSubview(blurEffectView)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        blurEffectView.addSubview(actInd)
        actInd.frame.origin = CGPoint(x:(blurEffectView.frame.width / 2) - (actInd.frame.width / 2) , y: (blurEffectView.frame.height / 2) - (actInd.frame.height / 2))
        actInd.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideActivityHud() -> (){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIView.animate(withDuration:0.2, animations: {
                self.blurEffectView.alpha = 0
            }, completion: { (done) in
                self.actInd.stopAnimating()
                self.blurEffectView.removeFromSuperview()
            })
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

