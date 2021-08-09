//
//  VisitViewController.swift
//  Toolty
//
//  Created by Suraj on 16/07/21.
//
//filterviewHeader
import UIKit
import FSCalendar
import MapKit

class VisitViewController: ParentViewController {
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    @IBOutlet weak var imgEmpty : UIImageView!
    
    var visitmodel = [visitModle]()
    var visitData = VisitdataModel()
    var objData : visitModle!
    var custLeadModel = [customersName]()
    var cusLead:customersName!
    var str = ""
    var nameAdd = ""
    var isFilter = false
    var isFilterString:String!
    var isisFilterId:String!
    
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        visitData.userID = _user.id
        visitData.custleadId = "0"
        visitData.visitStatus = "0"
        getVisit()
        visitData.date = Date.getCurrentDate()
        self.calendarview.select(Date())
        self.calendarview.scope = .week
        self.calendarview.reloadData()
        viewTop.constant = -160
        
        let label = LabelData.fetchDataFromEntity(predicate: nil, sortDescs: nil)
        for i in label[0..<2]{
            print(i.moduleName)
            str.append("\(i.moduleName)/")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        categoryArray.removeAll()
        filterARRAY.removeAll()
        
        getcustLeadname()
        prepareUI()
    }
    
    @IBAction func filterView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController
        categoryArray.append("Date")
        categoryArray.append(nameAdd)
        categoryArray.append(str)
//        categoryArray.append("Visit Status")
        vc!.curentdate = visitData.date
        vc!.str = str
        vc!.delegate = self
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
}


extension VisitViewController{
    func prepareUI(){
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: _tabBarHeight + 10, right: 0)
    }
    
    //    --> API CALLING
    func getVisit(){
        showHud()
        self.visitData.getVisitOverview {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            weakSelf.hideHud()
            if response == .success{
                
                weakSelf.objData = nil
                weakSelf.objData = data
                weakSelf.nameAdd = data.filterLabels!.userLabel
                if data.visits.count == 0{
                    weakSelf.imgEmpty.isHidden = false
                    
                    weakSelf.tableView.isHidden = true
                }else{
                    weakSelf.imgEmpty.isHidden = true
                    weakSelf.tableView.reloadData()
                    weakSelf.tableView.isHidden = false
                }
            }else{
                weakSelf.tableView.isHidden = true
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
    //    -> API CALLING CUSTOMERS LEAD NAME
    func getcustLeadname(){
        showHud()
        self.visitData.getcustLead{[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            weakSelf.hideHud()
            if response == .success{
                weakSelf.cusLead = nil
                weakSelf.cusLead = data
            }else{
                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
    //    --> DATE CONVERTER
    func convertSingleHoursFormater(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH"
        return  dateFormatter.string(from: date!)
    }
    func convertSingleMinutesFormater(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "mm a"
        return  dateFormatter.string(from: date!)
    }
    func convertSingletimeFormater(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm a"
        return  dateFormatter.string(from: date!)
    }
    
}
// -> TABLE VIEW DELEGATE AND DATASOURCE
extension VisitViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if objData != nil{
            return objData.visits.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "visitcell", for: indexPath) as? visitcell
        cell?.selectionStyle = .none
        let ind = objData.visits[indexPath.row]
        
        switch ind.visitStatus {
        case "0":
            cell?.statusView.backgroundColor = UIColor(named: "yellow_c")
        case "1":
            cell?.statusView.backgroundColor = UIColor(named: "green_c")
        case "2":
            cell?.statusView.backgroundColor = UIColor(named: "red_c")
        case "3":
            cell?.statusView.backgroundColor = UIColor(named: "gry_c")
        case "4":
            cell?.statusView.backgroundColor = UIColor(named: "blue_c")
        default:
            print("default")
        }
        cell?.DateLbl.text = convertSingleHoursFormater(ind.time)
        cell?.TimeLbl.text = convertSingleMinutesFormater(ind.time)
        cell?.DateTimeLbl.text = convertSingletimeFormater(ind.time)
        cell?.visitNote.text = ind.leadStatus
        cell?.name.text = ind.fullName
        cell?.companyName.text = ind.companyName
        cell?.address.text = ind.address
        cell?.desc.text = ind.visitContent
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if objData != nil && !objData.visits.isEmpty{
            return UITableView.automaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = objData.visits[indexPath.row]
        if type.visitStatus ==  "0"{
            self.performSegue(withIdentifier: "other", sender: type)
        }else if type.visitStatus == "2"{
            self.performSegue(withIdentifier: "reschedualVisit", sender: type)
        }else {
            self.performSegue(withIdentifier: "detail", sender: (type.visitStatus,type))
        }
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let obj = self.objData.visits[indexPath.row]
        
        let info = UIContextualAction(style: .normal, title: "info") { (action, view, completion) in
            //info data
            
            completion(true)
        }
        info.backgroundColor =  #colorLiteral(red: 0.1411764706, green: 0.2980392157, blue: 0.631372549, alpha: 0.3)
        
        let map = UIContextualAction(style: .normal, title: "Map") {(action, view, completion) in
            
            if obj.scheduleLatLng != ""{
                let final = obj.scheduleLatLng.components(separatedBy: ",")
                let latitude = final[0].replacingOccurrences(of: "\"", with: "")
                let long = final[1].replacingOccurrences(of: "\"", with: "")
                self.openMap(with: Double(latitude)!, long: Double(long)!)

            }
            completion(true)
        }
        map.image = UIImage(named: "ic_location")
        map.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.2980392157, blue: 0.631372549, alpha: 0.3)
        
        let call = UIContextualAction(style: .normal, title: "Call") {(action, view, completion) in
            self.openDialer(phoneNumber: obj.phone)
            completion(true)
        }
        
        call.image = UIImage(named: "ic_call")
        call.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.2980392157, blue: 0.631372549, alpha: 0.3)
        
        let email = UIContextualAction(style: .normal, title: "Email") {(action, view, completion) in
            self.openMail(email: obj.email)
            completion(true)
        }
        email.image = UIImage(named: "ic_email")
        email.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.2980392157, blue: 0.631372549, alpha: 0.3)
        
        let message = UIContextualAction(style: .normal, title: "Message") {(action, view, completion) in
            self.openMessageBar(phone: obj.phone)
            completion(true)
        }
        message.image = UIImage(named: "ic_message")
        message.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.2980392157, blue: 0.631372549, alpha: 0.3)
        
        let config = UISwipeActionsConfiguration(actions: [info,map,call,email,message])
        
        return config
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let vc = segue.destination as! DetailVisitsVC
            if let count = sender as? (String,Visit){
                vc.objVisits = count.1
            }
        }else if segue.identifier == "other"{
            let vc = segue.destination as! OtherVisitDetailVC
            if let visit = sender as? Visit{
                vc.objVisit = visit
            }
        }else if segue.identifier == "reschedualVisit"{
            let vc = segue.destination as! ReschedualVisitVC
            if let visit = sender as? Visit{
                vc.objVisit = visit
            }
        }
    }
}

// --> DELEGATE FUNC OF FILTER VALUE
extension VisitViewController:FilterValue{
    func getFiltervalue(Userinfo: [filterValuesStruct]) {
        for i in Userinfo{
            print(i)
            if i.DateType == "Current Date"{
                visitData.date = i.name!
                self.calendarview.select(Date.dateconvert(i.name!))
                self.calendarview.reloadData()
            }else if i.DateType == "Users"{
                visitData.userID = i.id!
            }else if i.DateType == "Lead/Customers/"{
                visitData.custleadId = i.id!
            }/*else if i.DateType == "Visit Status"{
                visitData.visitStatus = i.id!
            }*/
            
        }
        getVisit()
    }
}

// --> FSCALANDER DELEGATE CALLING
extension VisitViewController{
    //     func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
    //self.calendarHeightConstraint.constant = bounds.height
    //self.view.layoutIfNeeded()
    //    }
    
    override func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        visitData.date = self.dateFormatter.string(from: date)
        getVisit()
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    override func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}

//MARK:- Add Actions for Swipable View
extension VisitViewController{
    func openDialer(phoneNumber : String){
        let phoneUrl = "tel://\(phoneNumber)"
        let url:NSURL = NSURL(string: phoneUrl)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    func openMail(email : String){
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func openMessageBar(phone: String){
        let sms: String = "sms:\(phone)"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
    func openMap(with lat: Double, long : Double){
        //let url = "http://maps.apple.com/maps?saddr=\(lat),\(long)"
        //UIApplication.shared.openURL(URL(string:url)!)
        let coordinate = CLLocationCoordinate2DMake(lat,long)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}


//--> TABLE VIEW CELL
class visitcell:UITableViewCell{
    @IBOutlet weak var DateLbl:UILabel!
    @IBOutlet weak var TimeLbl:UILabel!
    @IBOutlet weak var DateTimeLbl:UILabel!
    @IBOutlet weak var statusView:UIView!
    @IBOutlet weak var visitNote:UILabel!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var companyName:UILabel!
    @IBOutlet weak var address:UILabel!
    @IBOutlet weak var desc:UILabel!
}

//--> DATE EXTENSION 
extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    static func dateconvert(_ currentDate:String) -> Date{
        let dateformate = DateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd"
        return dateformate.date(from: currentDate)!
    }
    
}
