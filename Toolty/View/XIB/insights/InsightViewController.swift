//
//  InsightViewController.swift
//  Toolty
//
//  Created by Suraj on 21/07/21.
//


import UIKit
import Alamofire
import SwiftyJSON
import Nuke
import ProgressHUD

struct overviewData{
    var id: String
    var name:String
    
}

var gID = _user.id

var graphID:String{
    get {
        return gID
    }
    set {
        gID = newValue
    }
}

class InsightViewController: UIViewController {
    let resID = "HeaderCollectionViewCell"
    let detailID = "DetailsCollectionViewCell"
    @IBOutlet weak var collectionHeader: UICollectionView!
    @IBOutlet weak var detailCollection: UICollectionView!
    @IBOutlet weak var chartview: UIView!
    
    var InsightData = insightData()
    var objData : insightModel!
    var overviewArray = [overviewData]()
    var detailArray = [Summary]()
    var img = ""
    var filter:Bool = false
    var type = "0"
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var screenSize: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
//        graphID = _user.id
        callHomeDatacompletion()
        let today = overviewData(id: "0", name: "Today")
        let week = overviewData(id: "1", name: "Week")
        let mont = overviewData(id: "2", name: "Month")
        let qut = overviewData(id: "3", name: "Quater")
        
        overviewArray.append(today)
        overviewArray.append(week)
        overviewArray.append(mont)
        overviewArray.append(qut)
        
        self.collectionHeader.register(UINib(nibName: resID, bundle: nil), forCellWithReuseIdentifier: resID)
        self.detailCollection.register(UINib(nibName: detailID, bundle: nil), forCellWithReuseIdentifier: detailID)
        NotificationCenter.default.addObserver(self, selector: #selector(showSpinningWheel(notification:)), name: NSNotification.Name(rawValue: "Insight"), object: nil)
    }
    @objc func showSpinningWheel(notification: NSNotification) {
        print(notification.userInfo)
        guard let id = notification.userInfo?["id"] as? String else{
            graphID = _user.id
            return
        }
//        print(id)
        graphID = id
        callHomeDatacompletion()
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
    }
    
    //    --> CHART ADD TO VIEW
    func addChar(){
        let stroy = UIStoryboard(name: "Entry", bundle: nil)
        let vc = stroy.instantiateViewController(withIdentifier: "cahrtpagerViewController")
        add(asChildViewController: vc, vi: chartview)
    }
    func add(asChildViewController viewController: UIViewController,vi:UIView) {
        addChild(viewController)
        vi.addSubview(viewController.view)
        viewController.view.frame = vi.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}

//--> API CALLING
extension InsightViewController{
    func callHomeDatacompletion() {
        ProgressHUD.show()
        self.InsightData.id = graphID
        self.InsightData.typeID = type
        self.InsightData.getinsight{[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objData = nil
                weakSelf.objData = data
                weakSelf.img = data.imageBaseURL!
                print(weakSelf.objData.summary.count)
                DispatchQueue.main.async {
                    weakSelf.detailCollection.delegate = self
                    weakSelf.detailCollection.dataSource = self
                    weakSelf.detailCollection.reloadData()
                    ProgressHUD.dismiss()
                    weakSelf.addChar()
                }
            }else{
                //                JTValidationToast.show(message: response.rawValue)
            }
        }
        
    }
}

// --> Collection view delegate and datasource
extension InsightViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionHeader:
            return overviewArray.count
        default:
            //            return detailArray.count
            return objData!.summary.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case collectionHeader:
            let cell : HeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: resID, for: indexPath) as! HeaderCollectionViewCell
            cell.titleLbl.text = overviewArray[indexPath.row].name
            
            return cell
        default:
            let cell:DetailsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: detailID, for: indexPath) as! DetailsCollectionViewCell
            //            let ind = detailArray[indexPath.row]
            let ind = objData!.summary[indexPath.row]
            let url = URL(string: img + ind.icon!)
            print(url)
            cell.valuesLbl.text = ind.value
            cell.updateLbl.text = ind.update!
            cell.updateValues.text = ind.name!
            Nuke.loadImage(with: url as! ImageRequestConvertible, into: cell.titleImg)
            if ind.update! >= "0.0"{
                cell.updateImg.image = UIImage(named: "upArrow")
                cell.updateLbl.textColor = UIColor(named:"green_c")
            }else{
                cell.updateImg.image = UIImage(named:"downArrow")
                cell.updateLbl.textColor = UIColor(named:"red_c")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case collectionHeader:
            let cell : HeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: resID, for: indexPath) as! HeaderCollectionViewCell
            cell.titleLbl.textColor = UIColor(named: "blue_c")
            type = overviewArray[indexPath.row].id
            callHomeDatacompletion()
        default:
            print("working")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionHeader{
            let cellwidth = collectionHeader.frame.width/4 - 20
            let cellheight = collectionHeader.frame.height-10
            return CGSize(width: cellwidth, height: cellheight)
        }else{
            return CGSize(width: self.view.frame.width/2 - 8, height:(self.view.frame.height/10))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }

    
}
