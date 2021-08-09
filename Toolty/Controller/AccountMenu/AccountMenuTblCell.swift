//
//  AccountMenuTblCell.swift
//  Toolty
//
//  Created by Chirag Patel on 20/07/21.
//

import UIKit


class AccountMenuTblCell: UITableViewCell {
   
    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var imgCustom : UIImageView!
    @IBOutlet weak var lblCustomTitle : UILabel!
    @IBOutlet weak var lblVersion : UILabel!
    
    
    func prepareCustomMenuCell(data : AccountMenu){
        imgCustom.image = UIImage(named: data.imgName)
        lblCustomTitle.text = data.title
    }
    
    func prepareMenuCell(data: MenuItems){
        imgIcon.image = UIImage(named: data.imgName)
        lblTitle.text = data.title
    }
    
    func moveToVC(data: AccountMenu,view : UIViewController){
        switch data.title {
        case "Language":
            debugPrint("Language Clicked")
            let storyboard = UIStoryboard(name: "Menu", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LanguageVC") as? LanguageVC
            vc!.modalPresentationStyle = .fullScreen
            view.present(vc!, animated: true)
            
      
        default:
            debugPrint("hello")
        }
        
    }
    func moveToNextVC(data: MenuItems,view : UIViewController){
        switch data.title {
        case "Language":
            debugPrint("Language Clicked")
            let storyboard = UIStoryboard(name: "Menu", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LanguageVC") as? LanguageVC
            vc!.modalPresentationStyle = .fullScreen
            view.present(vc!, animated: true)
        case "Contacts":
            debugPrint("Contacts Clicked")
            let storyboard = UIStoryboard(name: "Menu", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ContactListVC") as? ContactListVC
            vc!.modalPresentationStyle = .fullScreen
            view.present(vc!, animated: true)
        case "Deals":
            debugPrint("DealsLisVC Clicked")
            let storyboard = UIStoryboard(name: "Menu", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DealsLisVC") as? DealsLisVC
            vc!.modalPresentationStyle = .fullScreen
            view.present(vc!, animated: true)
//            DealsLisVC
        default:
            debugPrint("hello")
        }
        
    }

}
