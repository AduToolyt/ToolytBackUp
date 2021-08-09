//
//  SideMenuData.swift
//  Toolty
//
//  Created by Nizamudheen on 06/08/21.
//

import Foundation
class SideMenuData : NSObject{
    
    var arrImageData : [String] = []
    var arrMenuNames : [Int32] = [19, 0, 1, 16, 15, 2, 10, 3, 6, 13, 14, 21, 17, 18, 7, 5, 11, 9, 8, 12, 20/*,4*/]
    var arrayMenuItems : [MenuItems] = []
    var arrayMenuItem : [MenuItems] = []
    
    override init() {
        super.init()
        debugPrint("sidemenu initialisation")
    }
    
    func getMenuItems() -> [MenuItems]{
        arrayMenuItems.removeAll()
        if _privilege.contacts_menu_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Contacts", img: "", id: 19, url: nil))
        }
        if _privilege.lead_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Leads", img: "", id: 0,url: nil))
        }
        if _privilege.customerView == 1{
            arrayMenuItems.append(MenuItems.init(title: "Customers", img: "", id: 16,url: nil))
        }
        if _privilege.account_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Account", img: "", id: 15,url: nil))
        }
        if _privilege.distributor_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Distributors", img: "", id: 15,url: nil))
        }
        if _privilege.deal_estimated_value_edit == 1{
            arrayMenuItems.append(MenuItems.init(title: "Deals", img: "", id: 16,url: nil))
        }
        if _privilege.order_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Orders", img: "", id: 15,url: nil))
        }
        if _privilege.task_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Task", img: "", id: 16,url: nil))
        }
        if _privilege.service_job_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Jobs", img: "", id: 15,url: nil))
        }
        if _privilege.stock_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Stocks", img: "", id: 15,url: nil))
        }
        if _privilege.form_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Forms", img: "", id: 15,url: nil))
        }
        if _privilege.approval_form_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Approval", img: "", id: 15,url: nil))
        }
        if _privilege.broadcast_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Broadcast", img: "", id: 15,url: nil))
        }
        if _privilege.productView == "1"{
            arrayMenuItems.append(MenuItems.init(title: "Products", img: "", id: 15,url: nil))
        }
        if _privilege.expense_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Expenses", img: "", id: 15,url: nil))
        }
        if _privilege.leave_apply == 1{
            arrayMenuItems.append(MenuItems.init(title: "Leave", img: "", id: 15,url: nil))
        }
        if _privilege.attendance_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "Attendance", img: "", id: 15,url: nil))
        }
        if _privilege.dpr_view == 1{
            arrayMenuItems.append(MenuItems.init(title: "DPR", img: "", id: 15,url: nil))
        }
        arrayMenuItems.append(MenuItems.init(title: "Feeds", img: "", id: 15,url: nil))
        arrayMenuItems.append(MenuItems.init(title: "Language", img: languageIcon, id: 15,url: nil))
        
        var arrFilter : [AddMenu]{
            return _appDelegator.moreMenuData.filter{$0.showIn == "1"}
        }
        
        
        for i in 0 ..< arrFilter.count{
            arrayMenuItems.append(MenuItems.init(title: arrFilter[i].menuName, img: arrFilter[i].iconName, id: 15,url: arrFilter[i].link))
        }
        
        for i in 0 ..< arrFilter.count{
            debugPrint("moreOptiions :: \(arrFilter[i].menuName)")
        }
        
        for i in 0 ..< arrayMenuItems.count{
            debugPrint("arrayMenuItems :: \(arrayMenuItems[i].title)")
        }
        
        return arrayMenuItems
        
    }
}
