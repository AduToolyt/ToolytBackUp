//
//  Lead&CustomersViewController.swift
//  Toolty
//
//  Created by Suraj on 31/07/21.
//

import UIKit
import ProgressHUD
import Nuke

class LeadCustomerViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var listTbl: UITableView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var headerColl: UICollectionView!
    
    @IBOutlet weak var headerView: UIView!
    var cellId = "LeadCustTableViewCell"
    let HeaderColCellID = "HeaderCollectionViewCell"
    
    var objList : LeadList!
    var LeadListData = LeadlistMenuData()
    var viewName = String()
    var array = ["Anytime","in 7 Days","in 15 Days","in 30 days"]
    var page = 0
    var searchBar = UISearchBar()
    var leadArray = ["Status Type","Progress","Users","Source","Industry","Sort","Last Update","visited In","Called In","Created By","Extra","Classification","Tagged/Untagged"]
    var custArray = ["Progress","Users","Source","Industry","Sort","Last Update","visited In","Called In","Created By","Extra","Classification","Tagged/Untagged","Converted"]
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar(frame: CGRect(x: 0.0, y: -80.0, width: 204.0, height: 40.0))
        searchBar.backgroundColor = UIColor.clear
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .search
        searchBar.searchBarStyle = .default
        searchBar.delegate = self
        searchBar.placeholder = "Search Here...!"
        headerView.addSubview(searchBar)
        
        titleLbl.text = viewName
        listTbl.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        headerColl.register(UINib(nibName: HeaderColCellID, bundle: nil), forCellWithReuseIdentifier: HeaderColCellID)
        headerColl.reloadData()
        LeadListData.industriesID = "0"
        LeadListData.searchWord = ""
        LeadListData.sortID = "0"
        LeadListData.statusType = "0"
        LeadListData.user = _user.id
        LeadListData.pageNo = "\(page)"
        if viewName == "Lead"{
            getLeadList()
        }else{
            getcustList()
        }
    }

    
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.removeFromSuperview()
    }

    @IBAction func backActionBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterview(_ sender: Any) {
        let story = UIStoryboard(name: "Menu", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "FilterVCMenu") as? FilterVCMenu
        vc!.modalPresentationStyle = .fullScreen
        if viewName == "Lead"{
            vc?.cateogryDataArray = leadArray
        }else{
            vc?.cateogryDataArray = custArray
        }
        vc!.viewName = viewName
        vc!.delegate = self
        present(vc!, animated: true, completion: nil)
    }
}

// MARK -> SHOW SEARCH BAR UI
extension LeadCustomerViewController{
    @IBAction func searchActionButton(_ sender: Any) {
        searchBar.isHidden = false
        searchBar.frame = CGRect(x: 0.0, y: 86.5, width: headerView.layer.bounds.width, height: 60)
    }
}
// Mark -> SEARCH BAR DELEGATE
extension LeadCustomerViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange",searchText)}
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing",searchBar.text!)
        LeadListData.searchWord = searchBar.text!
        if viewName == "Lead"{
            getLeadList()
        }else{
            getcustList()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel click")
        searchBar.isHidden = true
    }
}

//MARK:- Api calling
extension LeadCustomerViewController{
    func getLeadList(){
        ProgressHUD.show()
        self.LeadListData.getLeadList {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objList = nil
                weakSelf.objList = data
                weakSelf.countLbl.text = "\(data.totalCount) Leads"
                DispatchQueue.main.async {
                    weakSelf.listTbl.delegate = self
                    weakSelf.listTbl.dataSource = self
                    weakSelf.listTbl.reloadData()
                    ProgressHUD.dismiss()
                }
            }else{
                print("error")
            }
        }
    }
    
    func getcustList(){
        ProgressHUD.show()
        self.LeadListData.getcustomersList {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}

            if response == .success{
                weakSelf.objList = nil
                weakSelf.objList = data
                weakSelf.countLbl.text = "\(data.totalCount) Customers"
                DispatchQueue.main.async {
                    weakSelf.listTbl.delegate = self
                    weakSelf.listTbl.dataSource = self
                    weakSelf.listTbl.reloadData()
                    ProgressHUD.dismiss()
                }
                
            }else{
//                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
    
    
    func leadStage(int:Int) -> (Int){
        var value = Int()
        for i in objList.leadStatus{
            if i.id == int{
                value = i.statusType
            }
        }
        return (value)
    }
    func leadStageval(int:Int) -> String {
        var value = String()
        for i in objList.leadStatus{
            if i.id == int{
                value = i.leadStatus
            }
        }
        return (value)
    }
}


//MARK:- Tableview Delegate & Datasource Methods
extension LeadCustomerViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewName == "Lead"{
            return objList.leads.count
        }else{
            return objList.customers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeadCustTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LeadCustTableViewCell
        if viewName == "Lead"{
            let ind = objList.leads[indexPath.row]
            cell.companyNameLbl.text = ind.companyName
            cell.fullnameLbl.text = ind.fullName
            cell.idLbl.text = "ID: \(ind.id)"
            let url = URL(string:cell.imgUrl + ind.image)
            let request = ImageRequest(
                url: url!,
                processors: [ImageProcessors.Circle()]
            )
            Nuke.loadImage(with: request, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "ic_Splash")), into: cell.imagevi)
            cell.setview(int: leadStage(int: ind.leadStatusID), val: leadStageval(int: ind.leadStatusID))
            if ind.taggedUserStatus == 1{
                cell.statusImg.image = UIImage(named: "tag")
            }
            cell.setclassificationImg(int: ind.leadClassification)
        }else{
            let ind = objList.customers[indexPath.row]
            cell.companyNameLbl.text = ind.companyName
            cell.fullnameLbl.text = ind.fullName
            cell.idLbl.text = "ID: \(ind.id)"
            let url = URL(string:cell.imgUrl + ind.image)
            let request = ImageRequest(
                url: url!,
                processors: [ImageProcessors.Circle()]
            )
            Nuke.loadImage(with: request, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "ic_Splash")), into: cell.imagevi)
            cell.setview(int: leadStage(int: ind.leadStatusID), val: leadStageval(int: ind.leadStatusID))
            if ind.taggedUserStatus == 1{
                cell.statusImg.image = UIImage(named: "tag")
            }
            cell.setclassificationImg(int: ind.leadClassification)
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight  = abs(diffHeight - frameHeight);
        if pullHeight != 0.0{
            print("load more trigger")
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [self] (timer:Timer) in
                self.page = self.page + 1
                LeadListData.pageNo = "\(page)"
                if viewName == "Lead"{
                    getLeadList()
                }else{
                    getcustList()
                }
            })
        }
    }
}

//MARK:- CollectionView Delegate & Datasource Methods
extension LeadCustomerViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderColCellID, for: indexPath) as! HeaderCollectionViewCell
        cell.titleLbl.text = "Visited \(array[indexPath.row])"
        cell.titleLbl.font = UIFont.systemFont(ofSize: 12)
//        cell.contentView.layer.borderWidth = 1
//        cell.contentView.layer.cornerRadius = 10
//        cell.contentView.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = headerColl.frame.width/3.5
        let cellheight = headerColl.frame.height
        return CGSize(width: cellwidth, height: cellheight)
    }
}

extension LeadCustomerViewController:FilterValue{
    func getFiltervalue(Userinfo: [filterValuesStruct]) {
        for i in Userinfo{
            switch i.DateType{
            case "Status Type":
                LeadListData.statusType = i.id!
            case "Progress":
                print(i)
            case "Users":
                LeadListData.user = i.id!
            case "Source":
                print(i)
            case "Industry":
                LeadListData.industriesID = i.id!
            case "Sort":
                LeadListData.sortID = i.id!
            case "Last Update":
                print(i)
            case "visited In":
                print(i)
            case "Called In":
                print(i)
            case "Created By":
                print(i)
            case "Extra":
                print(i)
            case "Classification":
                print(i)
            case "Tagged/Untagged":
                print(i)
            case "Converted":
                print(i)
            default:
                print("Nothing")
            }
        }
        if viewName == "Lead"{
            getLeadList()
        }else{
            getcustList()
        }
    }
}
