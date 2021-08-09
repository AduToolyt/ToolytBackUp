//
//  MyExpensesViewController.swift
//  Toolty
//
//  Created by Suraj on 05/08/21.
//

import UIKit
import ProgressHUD
import Nuke
struct headerData{
    var id:String
    var name:String
    var img:String
}

class MyExpensesViewController: UIViewController {
   
    var objExpList : ExpensesList!
    var ExpData = ExpensesData()
    
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var headerColl: UICollectionView!
    
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var moneySignLbl: UILabel!
    @IBOutlet weak var totalMoneyLbl: UILabel!
    @IBOutlet weak var approvedCountLbl:UILabel!
    @IBOutlet weak var claimedCountLbl:UILabel!
    
    let HeaderColCellID = "ExpenseCollectionViewCell"
    let billcell = "BillTableViewCell"
    let milagecell = "MilageTableViewCell"
    var viewName = ""
    var arrData = [headerData]()
    var cartArra = ["Status","Date","Users"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tablecellSetup()
        ExpData.user = _user.id
        ExpData.pageNo = "0"
        ExpData.expenseType = "1"
        ExpData.statusId = "4"
        fetchExpense()
        headerCollectionUI()
    }
    func headerCollectionUI(){
        let all = headerData(id: "4", name: "All", img: "ALL")
        let approved = headerData(id: "1", name: "Approved", img: "Approved")
        let rej = headerData(id: "0", name: "Not Approved", img: "Not Approved")
        let claim = headerData(id: "2", name: "Claimed", img: "Claimed")
        arrData.append(all)
        arrData.append(approved)
        arrData.append(rej)
        arrData.append(claim)
        
        headerColl.register(UINib(nibName: HeaderColCellID, bundle: nil), forCellWithReuseIdentifier: HeaderColCellID)
        headerColl.reloadData()
    }
    func tablecellSetup(){
        tblview.register(UINib(nibName: billcell, bundle: nil), forCellReuseIdentifier: billcell)
        tblview.register(UINib(nibName: milagecell, bundle: nil), forCellReuseIdentifier: milagecell)
    }
    @IBAction func backbutton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterButton(_ sender: Any) {
        let story = UIStoryboard(name: "Menu", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "FilterVCMenu") as? FilterVCMenu
        vc!.modalPresentationStyle = .fullScreen
        vc!.viewName = viewName
        vc!.cateogryDataArray = cartArra
        vc!.delegate = self
        present(vc!, animated: true, completion: nil)
    }
    
   
    @IBAction func expenseTypeButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            print("Bill")
            ExpData.expenseType = "1"
            fetchExpense()
        case 1:
            print("Milege")
            ExpData.expenseType = "2"
            fetchExpense()
        default:
            print("Nothing")
        }
    }
}
extension MyExpensesViewController{
    func fetchExpense(){
        ProgressHUD.show()
        self.ExpData.getExpList {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objExpList = nil
                weakSelf.objExpList = data
                weakSelf.countLbl.text = "\(data.totalCount) Expenses"
                weakSelf.moneySignLbl.text = data.companyCurrencySymbol
                weakSelf.totalMoneyLbl.text = data.totalSpent
                weakSelf.approvedCountLbl.text = data.approvedAmount
                weakSelf.claimedCountLbl.text = data.claimedAmount
                DispatchQueue.main.async {
                    weakSelf.tblview.delegate = self
                    weakSelf.tblview.dataSource = self
                    weakSelf.tblview.reloadData()
                    ProgressHUD.dismiss()
                }
            }else{
//                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
}
extension MyExpensesViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ExpenseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderColCellID, for: indexPath) as! ExpenseCollectionViewCell
        cell.titleLBl.text = arrData[indexPath.item].name
        cell.img.image = UIImage(named: arrData[indexPath.item].img)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = headerColl.frame.width/3.5
        let cellheight = headerColl.frame.height
        return CGSize(width: cellwidth, height: cellheight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ExpData.statusId = arrData[indexPath.item].id
        fetchExpense()
    }
    
}


extension MyExpensesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objExpList.expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ind = objExpList.expenses[indexPath.row]
        switch ExpData.expenseType{
        case "1":
            let cell:BillTableViewCell = tableView.dequeueReusableCell(withIdentifier: billcell, for: indexPath) as! BillTableViewCell
            cell.purposetypeLbl.text = ind.purposeType
            cell.amountLbl.text = "\(ind.amount)"
            cell.commentLbl.text = ind.comment
            cell.dateLbl.text = ind.date
            cell.expenseStatus.text = status(ind.expenseStatus)
            let url = URL(string:ind.invoiceImageURL!)
            if url != nil{
            let request = ImageRequest(
                url: url!,
                processors: [ImageProcessors.Circle()]
            )
                Nuke.loadImage(with: request, options: ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "ic_Splash")), into: cell.img)
            }
            return cell
        default:
            let cell:MilageTableViewCell = tableView.dequeueReusableCell(withIdentifier: milagecell, for: indexPath) as! MilageTableViewCell
            cell.purposetypeLbl.text = ind.purposeType
            cell.amountLbl.text = "\(ind.amount)"
            cell.place.text = ind.placeFrom
            cell.dateLbl.text = ind.date
            cell.distanceLbl.text = "\(ind.distance)"
            cell.expenseStatus.text = status(ind.expenseStatus)
            if ind.type == 2{
                if ind.bikeCar == 1{
                    cell.img.image = UIImage(named: "bike")
                }else{
                    cell.img.image = UIImage(named: "car")
                }
            }
           return cell
        }
    }
    
    func status(_ statusID:Int) -> String{
        var str = String()
        if statusID == 0{
            str = "Pending"
        }else if statusID == 1{
            str = "Approved"
        }else if statusID == 2{
            str = "Claimed"
        }else if statusID == 3{
            str = "Rejected"
        }
        return str
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
extension MyExpensesViewController:FilterValue{
    func getFiltervalue(Userinfo: [filterValuesStruct]) {
        for i in Userinfo{
            switch i.DateType{
            case "Status":
                ExpData.expenseType = i.id!
            case "Date":
                if i.value! == "Start Date"{
                    ExpData.formDate = i.name!
                }else if i.value! == "End Date"{
                    ExpData.toDate = i.name!
                }
            case "Users":
                ExpData.user = i.id!
            default:
                print("Nothing")
            }
        }
        fetchExpense()
    }
}
