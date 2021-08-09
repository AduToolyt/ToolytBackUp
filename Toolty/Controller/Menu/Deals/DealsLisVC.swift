//
//  ContactListVC.swift
//  Toolty
//
//  Created by Nizamudheen on 06/08/21.
//

import UIKit
import ContactsUI

class DealsLisVC: ParentUIController{
var dealsData = DealsListViewModel()
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var dealsTableView : UITableView!
    @IBOutlet weak var dealsAddButton : UIButton!
    @IBOutlet weak var searchButton : UIButton!
    @IBOutlet weak var filterButton : UIButton!
    @IBOutlet weak var lblCount : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        dealsTableView.delegate = self
        dealsTableView.dataSource = self
        dealsTableView.tableFooterView = UIView()
        lblTitle.text = "Deals".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getGloabalData()
        getTeamsFilterData()
        getZoneFilterData()
        getRegionFilterData()
        getUserFilterData()
        getDealsData()
    }

}

extension DealsLisVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealsData.dealsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dealsData.dealsList.count == 0{
            return UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DealsListTableViewCell", for: indexPath) as! DealsListTableViewCell
                return cell
        }
    }
}


extension DealsLisVC{
    func getGloabalData(){
        self.showActivityHud()
        dealsData.getGlobalregion(completion: { ResponseType, arrayList in
            self.hideActivityHud()
        })
    }
    func getTeamsFilterData(){
        self.showActivityHud()
        dealsData.getTeamsFilter(completion: { ResponseType, arrayList in
            self.hideActivityHud()
        })
    }
    
    func getZoneFilterData(){
        self.showActivityHud()
        dealsData.getZoneFilter(completion: { ResponseType, arrayList in
            self.hideActivityHud()
        })
    }
    func getRegionFilterData(){
        self.showActivityHud()
        dealsData.getRegionFilter(completion: { ResponseType, arrayList in
            self.hideActivityHud()
        })
    }
    func getUserFilterData(){
        self.showActivityHud()
        dealsData.getUserFilter(completion: { ResponseType, arrayList in
            self.hideActivityHud()
        })
    }
    
    func getDealsData(){
        self.showActivityHud()
        dealsData.getDeals(completion: { ResponseType, arrayList in
            
            debugPrint(" Result:::sssss \(arrayList)")
            self.hideActivityHud()
            self.dealsTableView.reloadData()
        })
    }
}
