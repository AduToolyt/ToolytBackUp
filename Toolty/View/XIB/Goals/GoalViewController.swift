//
//  GoalViewController.swift
//  Toolty
//
//  Created by Suraj on 23/07/21.
//

import UIKit
import Nuke
import ProgressHUD
import CircleProgressBar
class GoalViewController: UIViewController {
    let resID = "HeaderCollectionViewCell"
    let subGoalId = "SubGoalCollectionViewCell"
    
    @IBOutlet weak var collectionHeader: UICollectionView!
    @IBOutlet weak var goalImg: UIImageView!
    @IBOutlet weak var goalName: UILabel!
    @IBOutlet weak var goalProgress: UIProgressView!
    @IBOutlet weak var totalprogress: UILabel!
    @IBOutlet weak var achiveProgress: UILabel!
    @IBOutlet weak var subGoal: UICollectionView!
    @IBOutlet weak var showmoreBtn: UIButton!
    
    var objData : GoalModel!
    var goalData = GoalData()
    var filter = "0"
    var overviewArray = [overviewData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionHeader.register(UINib(nibName: resID, bundle: nil), forCellWithReuseIdentifier: resID)
        self.subGoal.register(UINib(nibName: subGoalId, bundle: nil), forCellWithReuseIdentifier: subGoalId)
        callgoalData()
        showmoreBtn.addTarget(self, action: #selector(showmore(_:)), for: .touchUpInside)
    }
    
    //    --> SHOW MORE ACTION BUTTON
    @objc func showmore(_ sender:UIButton){
        print("Show More")
        let newViewController = ShowMoreGoslsViewController(nibName: "ShowMoreGoslsViewController", bundle: nil)
        newViewController.modalPresentationStyle = .overFullScreen
        present(newViewController, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
}

//--> API CALLING goals_overview
extension GoalViewController{
    func callgoalData() {
        ProgressHUD.show()
        self.goalData.datafilter = filter
        self.goalData.getGoalBoard{[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objData = nil
                weakSelf.objData = data
                weakSelf.setUI(Img: data.activeData!.goalImage, goalname:data.activeData!.goalName , totalProgress: String(data.activeData!.totalGoalTargetAmount), goalProgressPercentage: data.activeData!.goalProgressPercentage)
                if data.activeData!.totalModulesCount >= 4{
                    weakSelf.showmoreBtn.isHidden = false
                }else{
                    weakSelf.showmoreBtn.isHidden = true
                }
                DispatchQueue.main.async {
                    weakSelf.collectionHeader.delegate = self
                    weakSelf.collectionHeader.dataSource = self
                    weakSelf.collectionHeader.reloadData()
                    weakSelf.subGoal.delegate = self
                    weakSelf.subGoal.dataSource = self
                    weakSelf.subGoal.reloadData()
                    ProgressHUD.dismiss()
                }
            }else{
                //                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
    
    //    --> MAIN Goal UI
    func setUI(Img:String,goalname:String,totalProgress:String,goalProgressPercentage:Int){
        let img = URL(string: _hostMode.baseUrl+Img) as! ImageRequestConvertible
        Nuke.loadImage(with: img, into: goalImg)
        goalName.text = goalname
        let progerssvalue = Float(goalProgressPercentage)/Float(totalProgress)!
        goalProgress.setProgress(progerssvalue, animated: true)
        //        goalProgress.transform = CGAffineTransform(scaleX: 1, y: 2)
        totalprogress.text = "Total target \(totalProgress)"
        achiveProgress.text = "\(goalProgressPercentage)" + "% Achived"
    }
    
}

// --> Collection view delegate and datasource
extension GoalViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionHeader:
            return arr.count
        default:
            if objData.activeData!.modules.count > 3{
                return 3
            }else{
                return objData.activeData!.modules.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case collectionHeader:
            let cell : HeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: resID, for: indexPath) as! HeaderCollectionViewCell
            cell.titleLbl.text = arr[indexPath.row].str
            return cell
        default:
            let cell:SubGoalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: subGoalId, for: indexPath) as! SubGoalCollectionViewCell
            let ind = objData.activeData!.modules[indexPath.row]
            cell.nameLbl.text = ind.moduleName
            cell.valuesLbl.text = "\(ind.completionPercentage) % achived"
            cell.cirProgressBar.setProgress(CGFloat(Float(ind.completionPercentage)!/Float(ind.subGoalTaget)), animated: true)
            cell.cirProgressBar.setHintTextGenerationBlock { (progress) -> String? in
                return String(format: "%.0f / \(ind.subGoalTaget)", progress * CGFloat(ind.tagetAchieved))
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionHeader{
            let cellwidth = collectionHeader.frame.width/4 - 20
            let cellheight = collectionHeader.frame.height-10
            return CGSize(width: cellwidth, height: cellheight)
        }else{
            let cellwidth = subGoal.frame.width/3-20
            let cellheight = subGoal.frame.height-10
            return CGSize(width: cellwidth, height: cellheight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionHeader{
            filter =  "\(arr[indexPath.item].val!)"
            callgoalData()
        }
    }
}

