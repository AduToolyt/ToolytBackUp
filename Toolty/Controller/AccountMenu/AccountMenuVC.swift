//
//  AccountMenuVC.swift
//  Toolty
//
//  Created by Chirag Patel on 20/07/21.
//

import UIKit

class AccountMenuVC: ParentViewController {
    @IBOutlet weak var imgProfile : UIImageView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblLogDetail : UILabel!
    var cell : AccountMenuTblCell!
    var arrCustomData : [AccountMenu] = []
    var sideMenu = SideMenuData()

    var arrFilter : [AddMenu]{
        return _appDelegator.arrAccountMenuData.filter{$0.showIn == "2"}
    }
    
    var arrayMenu : [MenuItems]{
        return sideMenu.getMenuItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        perpareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        perpareUI()
        debugPrint("Array Menu Items :: \(sideMenu.getMenuItems())")
    }
}

//MARK:- Other Methods
extension AccountMenuVC{
    func perpareUI(){
        
        addCustomData()
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: _tabBarHeight + 10, right: 0)
        tableView.reloadData()
    }
}


//MARK:- TableView Delegate & DataSource Methods
extension AccountMenuVC{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return arrayMenu.count
        }else if section == 1{
            return arrCustomData.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if indexPath.section  == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? AccountMenuTblCell
            cell.prepareMenuCell(data: arrayMenu[indexPath.row])
            return cell
            
        }else if indexPath.section == 1{
            
            cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? AccountMenuTblCell
            cell.prepareCustomMenuCell(data: arrCustomData[indexPath.row])
            return cell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as? AccountMenuTblCell
            cell.selectionStyle = .none
            return cell
        }
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            getVC(vcName: arrayMenu[indexPath.row].title, indepath: indexPath)
        case 1:
            print(arrCustomData[indexPath.row].title)
        default:
            print("Nothing")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.widthRatio
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    
    
    func getVC( vcName:String, indepath:IndexPath){
        let story = UIStoryboard(name: "Menu", bundle: nil)
        switch arrayMenu[indepath.row].title{
        case "Leads":
            let vc = story.instantiateViewController(withIdentifier: "LeadCustomerViewController") as! LeadCustomerViewController
            vc.viewName = vcName
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        case "Customers":
            let vc = story.instantiateViewController(withIdentifier: "LeadCustomerViewController") as! LeadCustomerViewController
            vc.viewName = vcName
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        case "Opportunity/Deal":
            print("No Opportunity/Deal")
        case "Task":
            print("No Task")
        case "New Visit":
            print("No New Visit")
        case "Schedule Visit":
            print("No Schedule Visit")
        case "Expense":
            let vc = story.instantiateViewController(withIdentifier: "MyExpensesViewController") as! MyExpensesViewController
            vc.viewName = vcName
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        case "Jobs":
            print("No Jobs")
        case "Leave":
            let vc = story.instantiateViewController(withIdentifier: "LeaveViewController") as! LeaveViewController
            vc.viewName = vcName
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        case "Form":
            print("NO Form")
        case "Start Beat":
            print("No Start Beat")
        case "Broadcast":
            print("No Broadcast")
        case "Approval":
            print("No Approval")
        case "Feeds":
            let vc = story.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
            vc.viewName = vcName
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        case "Language":
            debugPrint("Language Clicked")
            let storyboard = UIStoryboard(name: "Menu", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LanguageVC") as? LanguageVC
            vc!.modalPresentationStyle = .fullScreen
            present(vc!, animated: true)
        case "Contacts":
            debugPrint("Contacts Clicked")
            let storyboard = UIStoryboard(name: "Menu", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ContactListVC") as? ContactListVC
            vc!.modalPresentationStyle = .fullScreen
            present(vc!, animated: true)
        case "Deals":
            debugPrint("DealsLisVC Clicked")
            let storyboard = UIStoryboard(name: "Menu", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DealsLisVC") as? DealsLisVC
            vc!.modalPresentationStyle = .fullScreen
            present(vc!, animated: true)
        default:
            print("Nothing Show")
        }
    }
}



//MARK:- Add Custom Data
extension AccountMenuVC{
    func addCustomData(){
        if let time = _userDefault.object(forKey: "signInTime") as? String, let date = _userDefault.object(forKey: "signInDate") as? String{
            let changeTime = convertFormat(time: time)
            lblLogDetail.text = "Logged in at " + date + " " + changeTime
        }
        imgProfile.kf.setImage(with: _user.imgUrl)
        lblUserName.text = _user.name
        arrCustomData.removeAll()
        arrCustomData.append(contentsOf: [AccountMenu(title: "Help", img: helpIcon),AccountMenu(title: "FeedBack", img: feedbackIcon),AccountMenu(title: "Logout", img: logoutIcon)])
    }
    
    
    
    /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if indexPath.section == 0{
             cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? AccountMenuTblCell
             cell.moveToNextVC(data: arrayMenu[indexPath.row],view: self)
         }else if indexPath.section == 1{
             debugPrint("Custom")
 //            cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? AccountMenuTblCell
 //            cell.moveToVC(data: arrCustomData[indexPath.row],view: self)

         }else{
             debugPrint("last")
         }

     }
     */
} 

