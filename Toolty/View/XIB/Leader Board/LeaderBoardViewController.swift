//
//  LeaderBoardViewController.swift
//  Toolty
//
//  Created by Suraj on 22/07/21.
//
// start date - date diff - 1/7/31/...
// end date - today date -
//img url = base + "public/images/profile_pic/"+ img string
import UIKit
import Nuke
import ProgressHUD

var Startdate = ""
var Enddate = ""

class LeaderBoardViewController: UIViewController {
    @IBOutlet weak var collectionHeader: UICollectionView!
    @IBOutlet weak var leaderTbl: UITableView!
    let resID = "HeaderCollectionViewCell"
    let tblID = "LeaderBoardTableViewCell"
    
    var overviewArray = [overviewData]()
    var leaderboardData = LeaderBoardDate()
    var objData : LeaderBoardModel!
    var userID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userID = _user.id
        getDateFor()
        callHomeDatacompletion()
        self.collectionHeader.register(UINib(nibName: resID, bundle: nil), forCellWithReuseIdentifier: resID)
        self.leaderTbl.register(UINib(nibName: tblID, bundle: nil), forCellReuseIdentifier: tblID)

        NotificationCenter.default.addObserver(self, selector: #selector(showSpinningWheel(notification:)), name: NSNotification.Name(rawValue: "LeaderBoard"), object: nil)
    }
    @objc func showSpinningWheel(notification: NSNotification) {
        print(notification.userInfo)
        guard let vale = notification.userInfo?["DateType"] as? String else {return}
        if vale == "Start Date"{
            guard let startdat = notification.userInfo?["name"] as? String else {return}
            print("Start Date",startdat)
            Startdate = startdat
        }else if vale == "End Date"{
            guard let enddat = notification.userInfo?["name"] as? String else {return}
            print("End Date",enddat)
            Enddate = enddat
        }else if vale == "Users"{
            guard let id = notification.userInfo?["id"] as? String else{
                userID = _user.id
                return
            }
            print(id)
            userID = id
        }
        callHomeDatacompletion()
     }
//    --> check the date is valid formate or not
    func isValidDate(dateString: String) -> Bool {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        if let _ = dateFormatterGet.date(from: dateString) {
            return true
        } else {
            return false
        }
    }
    
    //-->    SET DATE FOR TODAY WEEK MONTH AND QUATAR
    func getDateFor(){
        let current = Date.serverDateString(from: Date(), format: "yyyy-MM-dd")
        let weekday = Date.serverDateString(from: Calendar.current.date(byAdding: .day, value: -7, to: Date()), format: "yyyy-MM-dd")
        let month = Date.serverDateString(from: Calendar.current.date(byAdding: .day, value: -30, to: Date()), format: "yyyy-MM-dd")
        let qutar = Date.serverDateString(from: Calendar.current.date(byAdding: .day, value: -90, to: Date()), format: "yyyy-MM-dd")
        Startdate = current
        Enddate = current
        let today = overviewData(id: current, name: "Today")
        let week = overviewData(id: weekday, name: "Week")
        let mont = overviewData(id: month, name: "Month")
        let qut = overviewData(id: qutar, name: "Quater")
        overviewArray.append(today)
        overviewArray.append(week)
        overviewArray.append(mont)
        overviewArray.append(qut)
    }
}

//--> API CALLING  get-leader-board-list
extension LeaderBoardViewController{
    func callHomeDatacompletion() {
        ProgressHUD.show()
        self.leaderboardData.Startdate = Startdate
        self.leaderboardData.Enddate = Enddate
        self.leaderboardData.userID = userID
        print(Enddate)
        self.leaderboardData.getLeaderBoard{[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objData = nil
                weakSelf.objData = data
                DispatchQueue.main.async {
                    weakSelf.leaderTbl.delegate = self
                    weakSelf.leaderTbl.dataSource = self
                    weakSelf.leaderTbl.reloadData()
                    ProgressHUD.dismiss()
                }
            }else{
                //                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
}

//--> MARK UITABLE VIEW DELEGATE AND DATASOURCE
extension LeaderBoardViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objData.leaderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeaderBoardTableViewCell = tableView.dequeueReusableCell(withIdentifier: tblID, for: indexPath) as! LeaderBoardTableViewCell
        let ind = objData.leaderList[indexPath.row]
        if Int(_user.id) == ind.id{
            cell.userNameLbl.text = "You"
        }else{
            cell.userNameLbl.text = ind.name
        }
        cell.userdesc.text = ind.category_name
        cell.usercountLbl.text = ind.point
        cell.countLbl.text = "\(indexPath.row + 1)"
        
        let url = URL(string:cell.imgUrl + ind.profile_pic)
        let request = ImageRequest(
            url: url!,
            processors: [ImageProcessors.Circle()]
        )
        Nuke.loadImage(with: request, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "ic_Splash")), into: cell.userImg)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//--> COLLECTION VIEW DELEGATE AND DATASOURCE
extension LeaderBoardViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return overviewArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: resID, for: indexPath) as! HeaderCollectionViewCell
        cell.titleLbl.text = overviewArray[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(overviewArray[indexPath.row].id)
        Startdate = overviewArray[indexPath.row].id
        callHomeDatacompletion()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellwidth = collectionHeader.frame.width/4 - 20
            let cellheight = collectionHeader.frame.height-10
            return CGSize(width: cellwidth, height: cellheight)
    }
}

