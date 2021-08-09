//
//  HomeVC.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit
var UID :String  = ""
class HomeVC: ParentViewController {
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var notiAlertView : UIView!
    @IBOutlet weak var alertbtn: UIButton!
    @IBOutlet weak var filterbtn: UIButton!
    
    var homeData = HomeData()
    var objData : Home!
    var status : Int = 0
    var unreadCount : Int = 0
    var nameAdd = ""
    var filData = userFilterData()
    var filterdata :UserFilter!
    let InsightVc = InsightViewController()
    let leaderboardVC = LeaderBoardViewController()
    let goalVc = GoalViewController()
    var arrData : [EnumHome] = [.collCell,.activityCell,.missedActivityCell]
    var stringName = String()
    var userID = String()
    var currentDate : String{
        let strDate = Date.localDateString(from: Date(), format: "EEEE, MMM d, yyyy")
        return strDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callHomeData()
        prepareUI()
        userID = _user.id
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        filterARRAY.removeAll()
        categoryArray.removeAll()
        
        getNotiCount()
        getUserFilter()
    }
    
    func hideBtn(){
        alertbtn.isHidden = true
        notiAlertView.isHidden = true
        filterbtn.isHidden = true
    }
    func showBtn(){
        alertbtn.isHidden = false
        notiAlertView.isHidden = false
        filterbtn.isHidden = false
    }
}

//MARK:- Others Methods
extension HomeVC{
    func prepareUI(){
        lblDate.text = currentDate
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: _tabBarHeight + 10, right: 0)
    }
    
    @IBAction func filterBtntapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController
        vc!.viewTitile = "overview"
        vc!.delegate = self
        if stringName == "" || stringName == "Today"{
            print("Today")
            categoryArray.append(nameAdd)
        }else if stringName == "Insights"{
            categoryArray.append(nameAdd)
            print("Insights")
        }else if stringName == "LeaderBoard"{
            vc!.modelName = "Leaderboard"
            vc!.startdate = Startdate
            vc!.enddate = Enddate
            categoryArray.append(nameAdd)
            categoryArray.append("Date")
            print("LeaderBoard")
        }
        
        
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    @IBAction func btnNotificationTapped(_ sender: UIButton){
        self.performSegue(withIdentifier: "notification", sender: unreadCount)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "notification"{
            let vc = segue.destination as! NotificationsVC
            vc.unreadCount = unreadCount
        }
    }
}

//MARK:- CollectionView Delegate and DataSource Methods
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeData.manuList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HomeCollCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! HomeCollCell
        cell.prepareMenu(data: homeData.manuList()[indexPath.row])
        cell.prepareImg(int: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        stringName = homeData.manuList()[indexPath.row].name
        switch homeData.manuList()[indexPath.row].name {
        case "Today":
            print(homeData.manuList()[indexPath.row].name)
            showBtn()
            remove_ViewController(viewController: InsightVc, vi: tableView)
            remove_ViewController(viewController: leaderboardVC, vi: tableView)
            remove_ViewController(viewController: goalVc, vi: tableView)
            tableView.isHidden = false
        case "Insights":
            print(homeData.manuList()[indexPath.row].name)
            showBtn()
            add(asChildViewController: InsightVc, vi: tableView)
        case "LeaderBoard":
            print(homeData.manuList()[indexPath.row].name)
            showBtn()
            add(asChildViewController: leaderboardVC, vi: tableView)
        case "Goal":
            print(homeData.manuList()[indexPath.row].name)
            hideBtn()
            add(asChildViewController: goalVc, vi: tableView)
        default:
            print(homeData.manuList()[indexPath.row].name)
        }
    }
}

//MARK:- CollectionView Delegate FlowLayout Methods
extension HomeVC : UICollectionViewDelegateFlowLayout{
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


//MARK:- TableView Delegate & DataSource Methods
extension HomeVC {
    func numberOfSections(in tableView: UITableView) -> Int {
        return objData != nil ? arrData.count : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objData != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else {return nil}
        let headerView = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as! HomeTblCell
        headerView.lblSectionTitle.text = arrData[section].sectionTitle
        if objData != nil && section == 2{
            let intActivityCount = objData.activitiesCount - 4
            var title  = ""
            if intActivityCount >= 0 {
                title =  "+\(intActivityCount) more activities"
            } else {
                title =  ""
            }
            headerView.btnSection.setTitle(title, for: .normal)
        }
        return headerView.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 40.widthRatio
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HomeTblCell
        let objCellData = arrData[indexPath.section]
        
        cell = tableView.dequeueReusableCell(withIdentifier: objCellData.cellId, for: indexPath) as! HomeTblCell
        cell.parentCell = self
        cell.cellType = objCellData
        
        if objCellData == .collCell || objCellData == .missedActivityCell{
            cell.topCollView.register(UINib(nibName: "EmptyCollCell", bundle: nil), forCellWithReuseIdentifier: "noDataCell")
            cell.topCollView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            cell.topCollView.reloadData()
        }else if objCellData == .activityCell{
            if objData != nil && objData.schedualCount >= 1{
                cell.prepareSchedualCell()
            }else{
                cell.dataView.isHidden = true
                cell.lblNoData.text = "There are no upcoming Activity"
                cell.noDataView.isHidden = false
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return arrData[indexPath.section].cellHeight
    }
}


//MARK:- WebCall Methods
extension HomeVC{
    func callHomeData(){
        showHud()
        self.homeData.uID = userID
        self.homeData.getOverview {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.objData = nil
                weakSelf.objData = data
                weakSelf.nameAdd = weakSelf.objData.filterLabel!.userLabel
                weakSelf.tableView.reloadData()
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
    
    func getUserFilter(){
        print(_user.id,_user.companyId)
        showHud()
        self.filData.getuserFilter {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.filterdata = nil
                weakSelf.filterdata = data
            }
        }
    }
    
    
    func getNotiCount(){
        showHud()
        self.homeData.getUnreadNotiCount {[weak self] (response, status, count) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.status = status
                weakSelf.unreadCount = count
                weakSelf.notiAlertView.isHidden = count == 0 ? true : false
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
}

extension HomeVC:FilterValue{
    func getFiltervalue(Userinfo: [filterValuesStruct]) {
        var NotificDict = [String: Any]()
       
        if stringName == "" || stringName == "Today"{
            for i in Userinfo{
                userID = i.id!
            }
                callHomeData()
        }else if stringName == "Insights"{
            for i in Userinfo{
                NotificDict = ["id":i.id!,"name":i.name!,"value":i.value!,"DateType":i.DateType!]
                NotificationCenter.default.post(name: NSNotification.Name("Insight"), object: nil, userInfo: NotificDict)
            }
           
        }else if stringName == "LeaderBoard"{
            for i in Userinfo{
                NotificDict = ["id":i.id!,"name":i.name!,"value":i.value!,"DateType":i.DateType!]
                NotificationCenter.default.post(name: NSNotification.Name("LeaderBoard"), object: nil, userInfo: NotificDict)
            }
        }
    }
    
//    func selectedFilterValue(id: String, name: String, isFilters: Bool) {
//        print(id,name,isFilters)
//        let NotificDict:[String: Any] = ["isFilterValue": isFilter,"isFilterId":id,"name":name]
//        if stringName == "" || stringName == "Today"{
//            print("Today")
//            isFilter = isFilters
//            isFilterId = id
//            userID = id
//            UID = id
//            callHomeData()
//        }else if stringName == "Insights"{
//            print("Insights")
//            NotificationCenter.default.post(name: NSNotification.Name("Insight"), object: nil, userInfo: NotificDict)
//        }else if stringName == "LeaderBoard"{
//            print("LeaderBoard")
//            NotificationCenter.default.post(name: NSNotification.Name("LeaderBoard"), object: nil, userInfo: NotificDict)
//        }
//    }
    
}
