//
//  LeaveViewController.swift
//  Toolty
//
//  Created by Suraj on 06/08/21.
//

import UIKit
import ProgressHUD
class LeaveViewController: UIViewController {
    @IBOutlet weak var headerCol: UICollectionView!
    @IBOutlet weak var leaveTbl: UITableView!
    
    var viewName = ""
    var objLeavList : LeaveModel!
    var leaveData = LeaveData()
    var headerCellId = "LeaveCollectionViewCell"
    var tblcellId = "LeaveTableViewCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupcollectionandTable()
        leaveData.user = _user.id
        leaveData.pageNo = "0"
        fetchLeave()
    }
    func setupcollectionandTable(){
        headerCol.register(UINib(nibName: headerCellId, bundle: nil), forCellWithReuseIdentifier: headerCellId)
        leaveTbl.register(UINib(nibName: tblcellId, bundle: nil), forCellReuseIdentifier: tblcellId)
    }
    @IBAction func NotificationView(_ sender: Any) {
        let story = UIStoryboard(name: "Menu", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LeaveRequestViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @IBAction func filterview(_ sender: Any) {
        let story = UIStoryboard(name: "Menu", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "FilterVCMenu") as? FilterVCMenu
        vc!.modalPresentationStyle = .fullScreen
        vc!.viewName = viewName
        vc!.cateogryDataArray.append("Users")
        vc!.delegate = self
        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension LeaveViewController{
    func fetchLeave(){
        ProgressHUD.show()
        self.leaveData.getLeaveList {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objLeavList = nil
                weakSelf.objLeavList = data
                DispatchQueue.main.async {
                    weakSelf.headerCol.delegate = self
                    weakSelf.headerCol.dataSource = self
                    weakSelf.headerCol.reloadData()
                    weakSelf.leaveTbl.delegate = self
                    weakSelf.leaveTbl.dataSource = self
                    weakSelf.leaveTbl.reloadData()
                    ProgressHUD.dismiss()
                }
            }else{
//                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
}
extension LeaveViewController:FilterValue{
    func getFiltervalue(Userinfo: [filterValuesStruct]) {
        for i in Userinfo{
            print(i)
            switch i.DateType{
            case "Users":
                leaveData.user = i.id!
            default:
                print("Nothing")
            }
        }
        fetchLeave()
    }
}

extension LeaveViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objLeavList.leavePolicies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LeaveCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellId, for: indexPath) as! LeaveCollectionViewCell
        let ind = objLeavList.leavePolicies[indexPath.item]
        cell.leavepolic.text = ind.masterLeavePolicy
        cell.outofLeave.text = "\(ind.leavesPending) of \(ind.leavesAllowance)"
        let processValue = Float(ind.leavesTaken)/Float(ind.leavesAllowance)
        cell.progressvi.setProgress(processValue, animated: true)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = headerCol.frame.width/3.5
        let cellheight = headerCol.frame.height
        return CGSize(width: cellwidth, height: cellheight)
    }
    
}
extension LeaveViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objLeavList.leaveApplied.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Leave(s)Applied"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeaveTableViewCell = tableView.dequeueReusableCell(withIdentifier: tblcellId, for: indexPath) as! LeaveTableViewCell
        let ind = objLeavList.leaveApplied[indexPath.row]
        cell.nameLbl.text = ind.userName
        cell.masterleavepolicy.text = ind.masterLeavePolicy
        cell.daterange.text = ind.leaveDateRange
        cell.daysCount.text = ind.daysLeaveTaken
        cell.getApproved(ind.approveRejectStatus)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let ind = objLeavList.leaveApplied[indexPath.row]
        if ind.approveRejectStatus == 0{
            return true
        }else{
            return false
        }
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let TrashAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)
        })
        TrashAction.backgroundColor = .green
        TrashAction.image = UIImage(named: "ic_tick")
        return UISwipeActionsConfiguration(actions: [TrashAction])
    }
    
}
