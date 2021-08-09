//
//  ReschedualVisitVC.swift
//  Toolty
//
//  Created by Chirag Patel on 23/07/21.
//

import UIKit

class ReschedualVisitVC: ParentViewController {
    @IBOutlet weak var lblText : UILabel!
    
    var viewType : EnumChangeView = .assign
    var reschedualData = RechedualVisitData()
    var arrData : [EnumReschedualVisit] = [.btnCell,.calenderCell,.timeCell,.locationCell,.alongCell]
    var arrSlots : [TimeSlots] = []
    var objVisit : Visit!
    var assignName = ""
    var arrAlongData : [AlongData] = []
    var places : NearPlaces?
    var isFromPlaces : Bool = false
    var contents = ""
    var placeLat : Double = 0.00
    var placeLong : Double = 0.00
    var isFromGooglePlace : Bool = false
    var address  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reschedualData.objVisitData = objVisit
        reschedualData.date = Date.getCurrentDate()
        getTime()
        prepareUI()
    }
}

//MARK:- Others Methods
extension ReschedualVisitVC{
    func prepareUI(){
        reschedualData.customerLead = "\(objVisit.customerID)"
        reschedualData.schedualNotes = contents
        contents = objVisit.visitContent
        if objVisit != nil {
            lblText.text = objVisit.visitContent
            assignName = objVisit.assigneeName
        }
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    @IBAction func btnAssignToTapped(_ sender : UIButton){
        self.viewType = EnumChangeView(val: 0)
        self.performSegue(withIdentifier: "assignTo", sender: self.viewType)
    }
    
    @IBAction func btnAlongWithTapped(_ sender: UIButton){
        self.viewType = EnumChangeView(val: 1)
        self.performSegue(withIdentifier: "assignTo", sender: self.viewType)
    }
    
    @IBAction func btnBackTapped( _ sender: UIButton){
        show(title: "Save Changes", msg: "Do you want Discard Changes?",btnTitle: "Discard", btnTitle1: "Keep") { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func btnCancelTapped(_ sender: UIButton){
        show(title: "Save Changes", msg: "Do you want Discard Changes?",btnTitle: "Discard", btnTitle1: "Keep") { _ in
            self.cancelVisit()
        }
    }
    
    @IBAction func btnPencilTapped(_ sender: UIButton){
        self.performSegue(withIdentifier: "notes", sender: contents)
    }
    
    @IBAction func btnRescheduleTapped(_ sender: UIButton){
        if reschedualData.assignId != "" && reschedualData.time != ""{
            self.submitVisitDetails()
        }else{
            self.showMessage(title: "Time Slot and Assign Id Required", msg: "")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "assignTo"{
            let vc = segue.destination as! AssignToVC
            vc.completion = {obj in
                self.assignName = obj.names
                self.reschedualData.assignId = obj.value
                self.tableView.reloadData()
            }
            vc.completionAlong = {arr in
                self.arrAlongData.append(contentsOf: arr)
                self.tableView.reloadData()
            }
            if let type = sender as? EnumChangeView{
                vc.type = type
            }
        } else if segue.identifier == "nearby"{
            let vc = segue.destination as! NearbyAreasVC
            if let location =  sender as? (Double,Double){
                vc.lat = location.0
                vc.long = location.1
            }
            vc.completion = {obj in
                self.isFromPlaces = true
                self.places = obj
                self.tableView.reloadData()
            }
            vc.completionLatLong = {lat, long, add in
                self.isFromGooglePlace = true
                self.placeLat = lat
                self.placeLong = long
                self.address = add
                self.tableView.reloadData()
            }
        }else if segue.identifier == "notes"{
            let vc = segue.destination as! NotesVC
            vc.completion = {str in
                self.contents = str
                self.lblText.text = str
                self.reschedualData.schedualNotes = self.contents
            }
            vc.content = contents
        }
    }
}


//MARK:- TableView Delegate & DataSource Methods
extension ReschedualVisitVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ReschedualVisitTblCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: arrData[indexPath.row].cellId, for: indexPath) as! ReschedualVisitTblCell
        cell.parent = self
        
        if arrData[indexPath.row] == .btnCell{
            cell.lblAssignName.text = assignName
            cell.prepareView()
        } else if arrData[indexPath.row] == .timeCell{
            cell.timeCollView.allowsMultipleSelection = true
            cell.timeCollView.reloadData()
        }else if arrData[indexPath.row] == .alongCell{
            cell.addNameCollView.reloadData()
        }else if arrData[indexPath.row] == .locationCell{
            cell.setupLocationManager()
            cell.getCoordinates()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return arrData[indexPath.row].cellHeight
    }
}


//MARK:- Get Time Slots WebCall Methods
extension ReschedualVisitVC{
    func getTime(){
        showHud()
        self.reschedualData.getTimeSlots {[weak self] (response, arrtime) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.arrSlots = []
                weakSelf.arrSlots = arrtime
                weakSelf.tableView.reloadData()
            }
        }
    }
}

//MARK:- Cancel User Visit WebCall Method
extension ReschedualVisitVC {
    func cancelVisit(){
        showHud()
        self.reschedualData.getCancelVisit {[weak self] (response) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.navigationController?.popViewController(animated: true)
            }
        }
    }
}

//MARK:- Submit ReschedualVisit Details WebCall Methods
extension ReschedualVisitVC{
    func submitVisitDetails(){
        showHud()
        self.reschedualData.reschedualVisit {[weak self] (response, status) in
            guard let weakSelf = self else {return}
            weakSelf.hideHud()
            if response == .success{
                if status == "0"{
                    weakSelf.show(title: "", msg: "Visits is already scheduled.",btnTitle: "Okay",btnTitle1: "Cancel", completion: nil)
                }else{
                    weakSelf.showMessage(title: "Success!", msg: "Visits Scheduled Successfully")
                    weakSelf.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

//MARK:- Show Popup Methods
extension ReschedualVisitVC{
    func show(title : String, msg : String,btnTitle : String, btnTitle1: String, completion : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: completion))
        alert.addAction(UIAlertAction(title: btnTitle1, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessage(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
