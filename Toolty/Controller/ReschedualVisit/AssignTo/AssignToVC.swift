//
//  AssignToVC.swift
//  Toolty
//
//  Created by Chirag Patel on 26/07/21.
//

import UIKit

class AssignToVC: ParentViewController {
    @IBOutlet weak var lblHeaderTitle : UILabel!
    @IBOutlet weak var btnSearch : UIButton!
    @IBOutlet weak var searchView : UIView!
    @IBOutlet weak var tfSearch : UITextField!
    @IBOutlet weak var btnAlongSearch : UIButton!
    
    var type : EnumChangeView = .along
    var completion : ((AlongData) -> ()) = {_ in}
    var completionAlong : (([AlongData]) -> ())  = {_ in}
    let reschedualData = RechedualVisitData()
    var arrSelectedAlongData : [AlongData] = []
    var arrSelectedAssignData : [AlongData] = []
    var arrAssignSearch : [AlongData] = []
    var isSearch : Bool = false
    var arrAlongData : [AlongData] = []
    var arrAlongSearch : [AlongData] = []
    var assignData : [Assign] = []
    
    var arrFilterAssignNames : [AlongData]{
        return arrSelectedAssignData.filter{$0.names != ""}
    }
    
    var arrAlongFilterNames : [AlongData]{
        return arrAlongData.filter{$0.names != ""}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        type == .assign ? getData() : getAlongData()
        setupAlongData()
    }
}

//MARK:- Others Methods
extension AssignToVC{
    func prepareUI(){
        tableView.allowsMultipleSelection = type == .along ? true : false
    }
    
    @IBAction func btnSearchTapped(_ sender: UIButton){
        if type == .assign{
            sender.isSelected.toggle()
            isSearch = sender.isSelected ? true : false
            searchView.isHidden = sender.isSelected ? false
                : true
            lblHeaderTitle.isHidden = sender.isSelected ? true : false
            arrAssignSearch = []
            prepareTextField()
        }else{
            completionAlong(arrSelectedAlongData)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnAlongSearchTapped(_ sender: UIButton){
        sender.isSelected.toggle()
        isSearch = sender.isSelected ? true : false
        searchView.isHidden = sender.isSelected ? false
            : true
        lblHeaderTitle.isHidden = sender.isSelected ? true : false
        arrAssignSearch = []
        prepareTextField()
    }
    
    func prepareTextField(){
        tfSearch.setAttributedPlaceHolder(text: "Search Here", font: UIFont.boldSystemFont(ofSize: 16), color: .white)
    }
}

//MARK:- TableView Delegate & DataSource Methods
extension AssignToVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type{
        case .assign:
            return isSearch ? arrAssignSearch.count : arrFilterAssignNames.count
        case .along:
            return isSearch ? arrAlongSearch.count : arrAlongFilterNames.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type{
        case .assign:
            let cell : AssignToTblCell
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! AssignToTblCell
            cell.parentVC = self
            cell.selectionStyle = .none
            if !arrFilterAssignNames.isEmpty || !arrAssignSearch.isEmpty{
                cell.lblName.text = isSearch ? arrAssignSearch[indexPath.row].names : arrFilterAssignNames[indexPath.row].names
            }
            return cell
        case .along:
            let cell : AssignToTblCell
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! AssignToTblCell
            cell.parentVC = self
            cell.prepareCell(data: arrAlongFilterNames[indexPath.row])
            if !arrAlongFilterNames.isEmpty || !arrAlongSearch.isEmpty{
                cell.lblName.text = isSearch ? arrAlongSearch[indexPath.row].names : arrAlongFilterNames[indexPath.row].names
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .assign{
            if isSearch{
                let objData = arrAssignSearch[indexPath.row]
                completion(objData)
                self.navigationController?.popViewController(animated: true)
            }else{
                let objData = arrFilterAssignNames[indexPath.row]
                completion(objData)
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
            let objAlongModel = arrAlongFilterNames[indexPath.row]
            setSelectedIdx(idx: indexPath.row)
            self.arrSelectedAlongData.append(objAlongModel)
            self.tableView.reloadData()
        }
    }
    
    func setSelectedIdx(idx: Int){
        for (index, data) in arrAlongFilterNames.enumerated(){
            if idx == index{
                data.isSelected = true
            }
        }
        tableView.reloadData()
    }
    
}

//MARK:- Get AssignData API Methods
extension AssignToVC{
    func getData(){
        showHud()
        self.reschedualData.getAssignData {[weak self] (response, arrVal, arrAssign) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.arrSelectedAssignData = []
                weakSelf.arrSelectedAssignData = arrVal
                weakSelf.tableView.reloadData()
            }
        }
    }
}

//MARK:- TextField Delegate Methods
extension AssignToVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let string1 = string
        let string2 = tfSearch.text
        var finalString = ""
        if string.count > 0 { // if it was not delete character
            finalString = string2! + string1
        }
        else if string2!.count > 0{ // if it was a delete character
            finalString = String(string2!.dropLast())
        }
        
        filteredArray(searchString: finalString)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func filteredArray(searchString:String){// we will use NSPredicate to find the string in array
        if type == .assign{
            arrAssignSearch = arrFilterAssignNames.filter({ (objData) -> Bool in
                let stringMatch = objData.names.range(of: searchString)
                return stringMatch != nil
            })
            tableView.reloadData()
        }else{
            arrAlongSearch = arrAlongFilterNames.filter({ (objData) -> Bool in
                let stringMatch = objData.names.range(of: searchString)
                return stringMatch != nil
            })
            tableView.reloadData()
        }
        if searchString == ""{
            tfSearch.text = ""
            isSearch = false
            tfSearch.resignFirstResponder()
            tableView.reloadData()
        }
    }
}

//MARK:- Get Along Data
extension AssignToVC{
    func getAlongData(){
        showHud()
        self.reschedualData.getAlongData {[weak self] (response, arrAlongModel, arrAssign) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.arrAlongData = []
                weakSelf.arrAlongData = arrAlongModel
                weakSelf.assignData = arrAssign
                weakSelf.tableView.reloadData()
            }
        }
    }
    
    func setupAlongData(){
        btnSearch.setImage(type == .assign ? UIImage(systemName: "magnifyingglass") : UIImage(named: ""), for: .normal)
        btnSearch.setTitle(type == .along ? "Ok" : "", for: .normal)
        btnAlongSearch.isHidden = type == .assign ? true : false
        lblHeaderTitle.isHidden = false
        lblHeaderTitle.text = type == .assign ? "Assign To" : "Along To"
    }
}
