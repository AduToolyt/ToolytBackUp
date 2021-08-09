//
//  FilterViewController.swift
//  Toolty
//
//  Created by Suraj on 16/07/21.
//

import UIKit

let cellReuseIdentifier = "FilterTableViewCell"
let cellNibName = "FilterTableViewCell"

struct filterValuesStruct{
    var id: String?
    var name:String?
    var value:String?
    var DateType:String?
}

var filterARRAY = [ValuesStruct]()

struct ValuesStruct{
    var id: String?
    var name:String?
    var value:String?
}

var categoryArray = [String]()

class FilterViewController: UIViewController {


    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var categoryTableView: UITableView!
    
    var datePicker:UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    weak var delegate : FilterValue?
    var filterUserinfo = [filterValuesStruct]()
    var viewTitile = ""
    var value = ""
    var arr = ["Type","Recommendation"]
    var Iid = ""
    var Iname = ""
    var str = ""
    var date = ""
    var curentdate = ""
    var startdate = ""
    var enddate = ""
    var modelName = ""
    var indexvalue = 0
    var valu = filterValuesStruct()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        filterARRAY.removeAll()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func filterApply(_ sender: Any) {
        print("Filter Applyed")
//        dismiss(animated: true) { [self] in
//            delegate?.selectedFilterValue(id: Iid, name: Iname, isFilters: true)
//        }
//        filterUserinfo.append(valu)
        let vak = removeDuplicateElements(post: filterUserinfo)
        dismiss(animated: true) { [self] in
            delegate?.getFiltervalue(Userinfo: vak)
        }
        
        for i in vak{
            print("Filter values are --> ",i.name!,i.id!,i.value!,i.DateType!)
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
    func showDatePicker(Index:IndexPath){
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { [self] _ in
            filterARRAY.removeAll()
            
            print("Selected Date: \(myDatePicker.date)")
            let dateval =  self.dateFormatter.string(from: myDatePicker.date)
            let date = ValuesStruct(id: "0", name: dateval,value: "Current Date")
            filterARRAY.append(date)
            
            let val = filterValuesStruct(id: filterARRAY[Index.row].id!, name: filterARRAY[Index.row].name!, value: categoryArray[indexvalue], DateType:filterARRAY[Index.row].value!)
            filterUserinfo.append(val)
            
            filterTableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)

     }
    
    func showstartDatePicker(Index:IndexPath){
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { [self] _ in
            filterARRAY.remove(at: Index.row)
            print("Selected Date: \(myDatePicker.date)")
            let dateval =  self.dateFormatter.string(from: myDatePicker.date)
            if Index.row == 0{
                
                let date = ValuesStruct(id: "0", name: dateval,value: "Start Date")
                filterARRAY.insert(date, at: Index.row)
                let val = filterValuesStruct(id: filterARRAY[Index.row].id!, name: filterARRAY[Index.row].name!, value: categoryArray[indexvalue], DateType:filterARRAY[Index.row].value!)
                filterUserinfo.append(val)
            }else{
                let date = ValuesStruct(id: "1", name: dateval,value: "End Date")
                filterARRAY.insert(date, at: Index.row)
                let val2 = filterValuesStruct(id: filterARRAY[Index.row].id!, name: filterARRAY[Index.row].name!, value: categoryArray[indexvalue], DateType:filterARRAY[Index.row].value!)
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


extension FilterViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case categoryTableView:
            return categoryArray.count
        default:
            return filterARRAY.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as? FilterTableViewCell
        switch tableView {
        case categoryTableView:
           
            cell?.headingLabel.text = categoryArray[indexPath.row]
                
            if filterARRAY.count == 0{
                filter(categoryArray[0])
            }
        default:
            cell?.headingLabel.text = filterARRAY[indexPath.row].name!
        }
        return cell!
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case categoryTableView:
            print("categoryTableView",categoryArray[indexPath.row])
            indexvalue = indexPath.row
            filter(categoryArray[indexPath.row])
        default:
            print("filterTableView  \(filterARRAY[indexPath.row])")
            let values = filterARRAY[indexPath.row]
            
            if modelName == "Leaderboard" && categoryArray[indexvalue] == "Date"{
                if dateValid(values.name!){
                    showstartDatePicker(Index: indexPath)
                }
            }else if dateValid(values.name!){
                showDatePicker(Index: indexPath)
                }else{
                    let value = filterValuesStruct(id: values.id!, name: values.name!,value: categoryArray[indexvalue],DateType: values.value)
                        filterUserinfo.append(value)
                
            }
        }
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
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            /*if modelName == ""{
        if let oldIndex = tableView.indexPathForSelectedRow {
                tableView.cellForRow(at: oldIndex)?.accessoryType = .none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }*/
        
//        let values = filterARRAY[indexPath.row]
//        print(values)
        return indexPath
            
    }
    
    func filter(_ String:String){
        filterARRAY.removeAll()
        if String == "Users"{
            let opt = UserList.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            let value = ValuesStruct(id: _user.id, name: "MySelf",value: "Users")
            filterARRAY.append(value)
            for i in opt{
                let iname = i.user_name
                let id = i.id
                let value = ValuesStruct(id: id, name: iname,value: "Users")
                filterARRAY.append(value)
            }
        }else if String == "Recommendation"{
            let mapOpt = MapsOption.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            let all = ValuesStruct(id: "0", name: "All",value: "Recommendation")
            let none = ValuesStruct(id: "0", name: "None",value: "Recommendation")
            filterARRAY.append(all)
            filterARRAY.append(none)
            for i in mapOpt{
//                filterArray.append(i.nearbyTypes)
                let id = "0"
                let val = ValuesStruct(id: id, name: i.nearbyTypes,value: "Recommendation")
                filterARRAY.append(val)
            }
        }else if String == "Type"{
            let Both = ValuesStruct(id: "-0", name: "Both",value: "Type")
            filterARRAY.append(Both)
            let label = LabelData.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            for i in label[0..<2]{
                let data = ValuesStruct(id: i.id, name: i.moduleName,value: "Type")
                filterARRAY.append(data)
            }
        }else if String == value{
            let All = ValuesStruct(id: "-0", name: "All",value: value)
            let Today = ValuesStruct(id: "0", name: value + " Today",value: value)
            let Anytime = ValuesStruct(id: "1", name: value + " Anytime",value: value)
            let No = ValuesStruct(id: "2", name: "No " + value,value: value)
            filterARRAY.append(All)
            filterARRAY.append(Today)
            filterARRAY.append(Anytime)
            filterARRAY.append(No)
        }else if String == "Date" && modelName == "Leaderboard"{
            let start = ValuesStruct(id: "0", name: startdate,value: "Start Date")
            let end = ValuesStruct(id: "1", name:enddate,value:"End Date")
            filterARRAY.append(start)
            filterARRAY.append(end)
        }else if String == "Date"{
            let date = ValuesStruct(id: "0", name: curentdate,value: "Current Date")
            filterARRAY.append(date)
        }else if String == str{
            let kab = CustLeadLists.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            let val = ValuesStruct(id: "0", name: "All",value: "Lead/Customers/")
            filterARRAY.append(val)
            for i in kab{
                let val = ValuesStruct(id: i.customer_id, name: i.customer_name,value: str)
                filterARRAY.append(val)
            }
        }else if String == "Visit Status"{
            let visttlist = VisitStatusFilter.fetchDataFromEntity(predicate: nil, sortDescs: nil)
            let val = ValuesStruct(id: "0", name: "All",value: "Visit Status")
            filterARRAY.append(val)
            for i in visttlist{
                print(i.id)
                let values = ValuesStruct(id: i.id, name: i.label, value: "Visit Status")
                filterARRAY.append(values)
            }
        }
        filterTableView.reloadData()
    }
    
}

