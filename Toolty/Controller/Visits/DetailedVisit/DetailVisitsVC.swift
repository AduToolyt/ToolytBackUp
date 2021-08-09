//
//  DetailVisitsVC.swift
//  Toolty
//
//  Created by Chirag Patel on 22/07/21.
//

import UIKit

class DetailVisitsVC: ParentViewController {
    var status : EnumStatusType = .green
    var objVisits : Visit!
    var visitDataModel = VisitData()
    var arrData : [VisitDetails] = []
    var fieldTitle : String = ""
    
    
    var arrFilter : [VisitDetails]{
        return arrData.filter{$0.fieldValue != ""}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visitDataModel.objVisit = objVisits
        getVisitData()
        prepareUI()
    }
}

//MARK:- Others Methods
extension DetailVisitsVC{
    func prepareUI(){
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 15, right: 0)
    }
}

//MARK:- TableView Delegate & DataSource Methods
extension DetailVisitsVC{

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilter.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objData = arrFilter[indexPath.row]
        let cell : DetailVisitTblCell
        let cellIdentifier = objData.isImage ? "cellImage" : "cellLable"
        cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailVisitTblCell
        
        cell.prepareCell(data: objData)
        fieldTitle = objData.field_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
}

//MARK:- Get Visit Details Web Call Methods
extension DetailVisitsVC{
    func getVisitData(){
        showHud()
        self.visitDataModel.getVisitData {[weak self] (response, arr) in
            guard let weakSelf = self else {return}
            if response == .success{
                weakSelf.hideHud()
                weakSelf.arrData = []
                weakSelf.arrData = arr
                weakSelf.tableView.reloadData()
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
}
