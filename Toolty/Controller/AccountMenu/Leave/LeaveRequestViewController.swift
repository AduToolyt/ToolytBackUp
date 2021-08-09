//
//  LeaveRequestViewController.swift
//  Toolty
//
//  Created by Suraj on 06/08/21.
//

import UIKit
import ProgressHUD

class LeaveRequestViewController: UIViewController {
    @IBOutlet weak var leaveTbl: UITableView!
    
    var objLeaveReq:LeaveReqModel!
    var leaveData = LeaveData()
    var tblcellId = "LeaveTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaveData.pageNo = "0"
        fetchLeaveReq()
        leaveTbl.register(UINib(nibName: tblcellId, bundle: nil), forCellReuseIdentifier: tblcellId)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
//
extension LeaveRequestViewController{
    func fetchLeaveReq(){
        ProgressHUD.show()
        self.leaveData.getLeaveReq {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objLeaveReq = nil
                weakSelf.objLeaveReq = data
                DispatchQueue.main.async {
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

extension LeaveRequestViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objLeaveReq.leaveRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeaveTableViewCell = tableView.dequeueReusableCell(withIdentifier: tblcellId, for: indexPath) as! LeaveTableViewCell
        let ind = objLeaveReq.leaveRequests[indexPath.row]
        cell.nameLbl.text = ind.userName
        cell.masterleavepolicy.text = ind.masterLeavePolicy
        cell.daterange.text = ind.leaveDateRange
        cell.daysCount.text = ind.daysLeaveTaken
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let ind = objLeaveReq.leaveRequests[indexPath.row]
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
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        
        let closeAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("CloseAction ...")
            success(true)
        })
        closeAction.backgroundColor = .red
        closeAction.image = UIImage(systemName: "xmark")
        return UISwipeActionsConfiguration(actions: [closeAction])
        
    }
}
