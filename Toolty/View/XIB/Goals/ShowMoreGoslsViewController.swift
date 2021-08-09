//
//  ShowMoreGoslsViewController.swift
//  Toolty
//
//  Created by Suraj on 26/07/21.
//

import UIKit
import ProgressHUD
import CircleProgressBar

class ShowMoreGoslsViewController: UIViewController {
    var objData : MoreGoals!
    var goalData = GoalData()
    var filter = "0"
    var showmoreCellId = "showmoreTableViewCell"
    @IBOutlet weak var moregoaltbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callMoregoalData()
        self.moregoaltbl.register(UINib(nibName: showmoreCellId, bundle: nil), forCellReuseIdentifier: showmoreCellId)
    }
    
    @IBAction func backActBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ShowMoreGoslsViewController{
    func callMoregoalData() {
        ProgressHUD.show()
        self.goalData.datafilter = filter
        self.goalData.getMoreGoalBoard{[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objData = nil
                weakSelf.objData = data
                DispatchQueue.main.async {
                    weakSelf.moregoaltbl.delegate = self
                    weakSelf.moregoaltbl.dataSource = self
                    weakSelf.moregoaltbl.reloadData()
                    ProgressHUD.dismiss()
                }
            }else{
                
            }
        }
    }
}


extension ShowMoreGoslsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objData.modules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : showmoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: showmoreCellId, for: indexPath) as! showmoreTableViewCell
        let ind = objData.modules[indexPath.row]
        cell.nameLbl.text = ind.moduleName
        cell.targetLbl.text = "Target achived \(ind.subGoalTaget)"
        cell.cirProgressBar.setProgress(CGFloat(ind.tagetAchieved/ind.subGoalTaget), animated: true)
        
        cell.cirProgressBar.setHintTextGenerationBlock { (progress) -> String? in
            return String(format: "%.0f\(ind.tagetAchieved)")
        }
        cell.valueLbl.text = ind.completionPercentage
        cell.descLbl.text = ind.periodicityName
        
        cell.compLbl.text = ind.completionPercentage + "% completed"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
