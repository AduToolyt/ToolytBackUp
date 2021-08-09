//
//  FilterVCMenu.swift
//  Toolty
//
//  Created by Suraj on 04/08/21.
//

struct filterDataArray{
    var name:String!
    var id:String!
    var value:String!
}

import UIKit

class FilterVCMenu: UIViewController {
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var categoryTableView: UITableView!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    weak var delegate : FilterValue?
    var cateogryDataArray = [String]()
    var filterArrayData = [filterDataArray]()
    var filterUserinfo = [filterValuesStruct]()
    var indexvalue = 0
    var viewName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView(){
        categoryTableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        categoryTableView.rowHeight = UITableView.automaticDimension
        categoryTableView.estimatedRowHeight = 100
        categoryTableView.tableFooterView = UIView(frame: .zero)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.reloadData()
        
        filterTableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        filterTableView.rowHeight = UITableView.automaticDimension
        filterTableView.estimatedRowHeight = 100
        filterTableView.separatorStyle = .none
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterApplyButton(_ sender: Any) {
        let val = removeDuplicateElements(post: filterUserinfo)
        print(val)
        dismiss(animated: true) { [self] in
            delegate?.getFiltervalue(Userinfo: val)
        }
    }
    func removeDuplicateElements(post: [filterValuesStruct]) -> [filterValuesStruct] {
        var uniquePosts = [filterValuesStruct]()
        for post in post.reversed() {
            if !uniquePosts.contains(where: {$0.DateType! == post.DateType! }) {
                uniquePosts.append(post)
            }
        }
        return uniquePosts
    }
    func dateValid(_ date:String) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let _ = dateFormatter.date(from:date) {
            return true
        }else {
            return false
        }
    }
    func showstartDatePicker(Index:IndexPath){
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { [self] _ in
            filterArrayData.remove(at: Index.row)
            print("Selected Date: \(myDatePicker.date)")
            let dateval =  self.dateFormatter.string(from: myDatePicker.date)
            print(indexvalue)
            if Index.row == 0{
                let date = filterDataArray(name: dateval, id: "0",value: "Start Date")
                filterArrayData.insert(date, at: Index.row)
                let val = filterValuesStruct(id: filterArrayData[Index.row].id!, name: filterArrayData[Index.row].name!, value: cateogryDataArray[indexvalue], DateType:filterArrayData[Index.row].value!)
                filterUserinfo.append(val)
            }else{
                let date = filterDataArray(name: dateval, id: "1",value: "End Date")
                filterArrayData.insert(date, at: Index.row)
                let val2 = filterValuesStruct(id: filterArrayData[Index.row].id!, name: filterArrayData[Index.row].name!, value: cateogryDataArray[indexvalue], DateType:filterArrayData[Index.row].value!)
                filterUserinfo.append(val2)
            }
            filterTableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}


extension FilterVCMenu: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case categoryTableView:
            return cateogryDataArray.count
        default:
            return filterArrayData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as? FilterTableViewCell
        switch tableView {
        case categoryTableView:
            cell?.headingLabel.text = cateogryDataArray[indexPath.row]
            if filterArrayData.count == 0{
                if viewName == "Lead" || viewName == "Customer"{
                    filterLeadCust(cateogryDataArray[0])
                }else if viewName == "Expense"{
                    filterExpense(cateogryDataArray[0])
                }else if viewName == "Leave" || viewName == "Feed"{
                    filterLeave(cateogryDataArray[0])
                }
            }
        default:
            cell?.headingLabel.text = filterArrayData[indexPath.row].name
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case categoryTableView:
            print("categoryTableView",cateogryDataArray[indexPath.row])
            indexvalue = indexPath.row
            if viewName == "Lead" || viewName == "Customer"{
                filterLeadCust(cateogryDataArray[indexPath.row])
            }else if viewName == "Expense"{
                filterExpense(cateogryDataArray[indexPath.row])
            }else if viewName == "Leave" || viewName == "Feed"{
                filterLeave(cateogryDataArray[indexPath.row])
            }
        default:
            print("filterTableView  \(filterArrayData[indexPath.row])")
            let values = filterArrayData[indexPath.row]
            if cateogryDataArray[indexvalue] == "Date"{
                if dateValid(values.name!){
                    showstartDatePicker(Index: indexPath)
                }
            }else{
                let value = filterValuesStruct(id: values.id!, name: values.name!,value: cateogryDataArray[indexvalue],DateType: values.value)
                filterUserinfo.append(value)
            }
        }
    }
}

extension FilterVCMenu{
    //    --> lead and customers filter
    func filterLeadCust(_ String:String){
        print( String)
        filterArrayData.removeAll()
        switch String{
        case "Status Type":
            let active = filterDataArray(name: "Active", id: "0", value: String)
            let lost = filterDataArray(name: "Lost", id: "1", value: String)
            filterArrayData.append(active)
            filterArrayData.append(lost)
            
        case "Progress":
            let val = LeadViewleadStatus.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            for i in val{
                let va = filterDataArray(name: i.lead_status, id: i.id, value: String)
                filterArrayData.append(va)
            }
        case "Users":
            let opt = UserList.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            let MySelf = filterDataArray(name: "MySelf", id: _user.id,value: String)
            let All = filterDataArray(name: "All", id: "0",value: String)
            let val = [MySelf,All]
            filterArrayData = val
            for i in opt{
                let value = filterDataArray(name: i.user_name, id: i.id,value: String)
                filterArrayData.append(value)
            }
        case "Source":
            let value = LeadViewleadSource.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            for i in value{
                let value = filterDataArray(name: i.source_name, id: i.id,value: String)
                filterArrayData.append(value)
            }
        case "Industry":
            let value = LeadViewindustries.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            for i in value{
                let value = filterDataArray(name: i.industry_name, id: i.id,value: String)
                filterArrayData.append(value)
            }
        case "Sort":
            let All = filterDataArray(name: "Alphabetical", id: "0",value: String)
            let recentlycreate = filterDataArray(name: "Recently Created", id: "1",value: String)
            let recentupdate = filterDataArray(name: "Recently Update", id: "2",value: String)
            let val = [All,recentlycreate,recentupdate]
            filterArrayData = val
        case "Last Update":
            print("update")
            let all = filterDataArray(name: "All", id: "0",value: String)
            let Sevendays = filterDataArray(name: "7 Days", id: "1",value: String)
            let fifteendays = filterDataArray(name: "15 Days", id: "2",value: String)
            let thirtydays = filterDataArray(name: "30 Days", id: "3",value: String)
            let sixteendays = filterDataArray(name: "60 Days", id: "4",value: String)
            let nintydays = filterDataArray(name: "90 Days", id: "5",value: String)
            let morethen = filterDataArray(name: "More then 90 days", id: "6",value: String)
            let val = [all,Sevendays,fifteendays,thirtydays,sixteendays,nintydays,morethen]
            filterArrayData = val
        case "visited In":
            let all = filterDataArray(name: "All", id: "0",value: String)
            let Sevendays = filterDataArray(name: "7 Days", id: "1",value: String)
            let fifteendays = filterDataArray(name: "15 Days", id: "2",value: String)
            let thirtydays = filterDataArray(name: "30 Days", id: "3",value: String)
            let sixteendays = filterDataArray(name: "60 Days", id: "4",value: String)
            let nintydays = filterDataArray(name: "90 Days", id: "5",value: String)
            let morethen = filterDataArray(name: "More then 90 days", id: "6",value: String)
            let never = filterDataArray(name: "Never", id: "7",value: String)
            let val = [all,Sevendays,fifteendays,thirtydays,sixteendays,nintydays,morethen,never]
            filterArrayData = val
        case "Called In":
            print("Privilage Depend")
        /*
         let all = filterDataArray(name: "All", id: "0",value: String)
         let Sevendays = filterDataArray(name: "7 Days", id: "1",value: String)
         let fifteendays = filterDataArray(name: "15 Days", id: "2",value: String)
         let thirteendays = filterDataArray(name: "30 Days", id: "3",value: String)
         let sixteendays = filterDataArray(name: "60 Days", id: "4",value: String)
         let nintydays = filterDataArray(name: "90 Days", id: "5",value: String)
         let morethen = filterDataArray(name: "More then 90 days", id: "6",value: String)
         filterArrayData.append(all)
         filterArrayData.append(Sevendays)
         filterArrayData.append(fifteendays)
         filterArrayData.append(sixteendays)
         filterArrayData.append(nintydays)
         filterArrayData.append(morethen)
         */
        case "Created By":
            let value = LeadViewUserList.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            for i in value{
                let ms = filterDataArray(name: i.user_name, id: i.id, value: String)
                filterArrayData.append(ms)
            }
        case "Extra":
            let all = filterDataArray(name: "All", id: "0",value: String)
            let Tapped = filterDataArray(name: "Tapped", id: "1",value: String)
            let Untapped = filterDataArray(name: "Untapped", id: "2",value: String)
            let NoTagging = filterDataArray(name: "No Tagging", id: "3",value: String)
            let Visited = filterDataArray(name: "Visited by Someone else", id: "5",value: String)
            //               let CIBIL = filterDataArray(name: "CIBIL  Generated", id: "6",value: String)
        //               filterArrayData.append(CIBIL) // privilage
            let val = [all,Tapped,Untapped,NoTagging,Visited]
            filterArrayData = val
        case "Classification":
            let all = filterDataArray(name: "All", id: "0",value: String)
            let Hot = filterDataArray(name: "Hot", id: "1",value: String)
            let Warm = filterDataArray(name: "Warm", id: "2",value: String)
            let Cold = filterDataArray(name: "Cold", id: "3",value: String)
            let val = [all,Hot,Warm,Cold]
            filterArrayData = val
        case "Tagged/Untagged":
            let all = filterDataArray(name: "All", id: "0",value: String)
            let Tagged = filterDataArray(name: "Tagged", id: "1",value: String)
            let UnTagged = filterDataArray(name: "UnTagged", id: "2",value: String)
            let val = [all,Tagged,UnTagged]
            filterArrayData = val
        case "Converted":
            let all = filterDataArray(name: "All", id: "0",value: String)
            filterArrayData.append(all)
        default:
            print("nothing")
        }
        filterTableView.reloadData()
    }
    
    //    --> Expense filter
    func filterExpense(_ String:String){
        filterArrayData.removeAll()
        switch String{
        case "Status":
            let all = filterDataArray(name: "All", id: "4", value: String)
            let approved = filterDataArray(name: "Approved", id: "1", value: String)
            let notapproved = filterDataArray(name: "Not Apporved", id: "0", value: String)
            let claim = filterDataArray(name: "Claim", id: "2", value: String)
            let notcalim = filterDataArray(name: "Not Claimed", id: "1", value: String)
            let rejected = filterDataArray(name: "Rejected", id: "3", value: String)
            let val = [all,approved,notapproved,claim,notcalim,rejected]
            filterArrayData = val
            
        case "Date":
            let current = Date.serverDateString(from: Date(), format: "yyyy-MM-dd")
            let start = filterDataArray(name: current, id: "0",value: "Start Date")
            let end = filterDataArray(name:current, id: "1",value:"End Date")
            let val = [start,end]
            filterArrayData = val
        case "Users":
            let my = filterDataArray(name: "MySelf", id:_user.id, value: String)
            filterArrayData.append(my)
            let value = LeadViewUserList.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            for i in value{
                let ms = filterDataArray(name: i.user_name, id: i.id, value: String)
                filterArrayData.append(ms)
            }
        default:
            print("nothing")
        }
        filterTableView.reloadData()
    }
    
    //    --> Leave and feed filter
    func filterLeave(_ String:String){
        filterArrayData.removeAll()
        switch String{
        case "Users":
            let my = filterDataArray(name: "MySelf", id:_user.id, value: String)
            filterArrayData.append(my)
            let value = LeadViewUserList.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            for i in value{
                let ms = filterDataArray(name: i.user_name, id: i.id, value: String)
                filterArrayData.append(ms)
            }
        default:
            print("nothing")
        }
        filterTableView.reloadData()
    }
}
