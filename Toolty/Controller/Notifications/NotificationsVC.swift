//
//  NotificationsVC.swift
//  Toolty
//
//  Created by Chirag Patel on 12/07/21.
//

import UIKit

class NotificationsVC: ParentViewController {
    var notiData = NotificationData()
    var objNotiData : Notifications!
    var arrNotiListData : [NotificationList] = []
    var unreadCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNotification()
        prepareUI()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- Other Methods
extension NotificationsVC{
    func prepareUI(){
        getNoDataCell()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
    }
    
    @IBAction func btnReadAllNotification(_ sender: UIButton){
        self.readAllNotifications()
    }
    
    @IBAction func btnViewNotificationTapped(_ sender: UIButton){
        let notiData = arrNotiListData[sender.tag]
        self.performSegue(withIdentifier: "details", sender: notiData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details"{
            let vc = segue.destination as! NotificationViewVC
            if let objNoti = sender as? NotificationList{
                vc.objData = objNoti
            }
        }
    }
}

//MARK:- Tableview Delegate & DataSource Methods
extension NotificationsVC{
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            if arrNotiListData.isEmpty{
                return 1
            }
            return arrNotiListData.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell : NotificationsTblCell
            
            cell = tableView.dequeueReusableCell(withIdentifier: "btnCell", for: indexPath) as! NotificationsTblCell
            cell.selectionStyle = .none
            return cell
        }
        if arrNotiListData.isEmpty{
            let cell : NoDataTableCell
            
            cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell") as! NoDataTableCell
            
            cell.setText(str: "No Notification Available")
            
            return cell
        }
        
        let cell : NotificationsTblCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "notiListCell", for: indexPath) as! NotificationsTblCell
        cell.btnView.tag = indexPath.row
        cell.parentVC = self
        cell.prepareNotificationCell(data: arrNotiListData[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return unreadCount == 0 ? 0 : 40
        }
        if arrNotiListData.isEmpty{
            return tableView.frame.size.height - (_bottomAreaSpacing + _tabBarHeight)
        }else{
            return UITableView.automaticDimension
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let data = arrNotiListData[indexPath.row]
            self.unreadNotification(param: ["notification_id" : data.id])
        }
    }
}

//MARK:- Notification Data
extension NotificationsVC{
    func getNotification(){
        showHud()
        self.notiData.getNotification {[weak self] (response, obj, arr) in
            guard let weakSelf = self, let objData = obj else{return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.arrNotiListData = []
                weakSelf.objNotiData = objData
                weakSelf.arrNotiListData = arr
                weakSelf.tableView.reloadData()
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
    
    func unreadNotification(param: [String : Any]){
        showHud()
        self.notiData.readNotification(param: param) {[weak self] (response) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                //                weakSelf.getNotification()
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
    
    func readAllNotifications(){
        showHud()
        self.notiData.markAsReadAllNoti {[weak self] (response) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.getNotification()
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
}
