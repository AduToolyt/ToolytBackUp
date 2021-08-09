//
//  FeedViewController.swift
//  Toolty
//
//  Created by Suraj on 07/08/21.
//

import UIKit
import ProgressHUD

class FeedViewController: UIViewController {
    
    var viewName = String()
    var objFeed : FeedModel!
    var feedDate = FeedData()
    var feedArr = [feedArray]()
    
    @IBOutlet weak var headerCol: UICollectionView!
    @IBOutlet weak var feedTbl: UITableView!
    @IBOutlet weak var topicName:UILabel!
    
    var cellId = "FeedTableViewCell"
    let HeaderColCellID = "HeaderCollectionViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let all = feedArray(id: "", name: "All")
        feedArr.append(all)
        feedDate.user = _user.id
        feedDate.page = "0"
        fetchFeed()
        headerCol.register(UINib(nibName: HeaderColCellID, bundle: nil), forCellWithReuseIdentifier: HeaderColCellID)
        headerCol.reloadData()
        feedTbl.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filter(_ sender: Any) {
        let story = UIStoryboard(name: "Menu", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "FilterVCMenu") as? FilterVCMenu
        vc!.modalPresentationStyle = .fullScreen
        vc!.viewName = viewName
        vc!.cateogryDataArray.append("Users")
        vc!.delegate = self
        present(vc!, animated: true, completion: nil)
    }
    
}
extension FeedViewController{
    func fetchFeed(){
        ProgressHUD.show()
        self.feedDate.getFeedList {[weak self] (response, obj) in
            guard let weakSelf = self, let data = obj else {return}
            if response == .success{
                weakSelf.objFeed = nil
                weakSelf.objFeed = data
                DispatchQueue.main.async {
                    weakSelf.feedTbl.delegate = self
                    weakSelf.feedTbl.dataSource = self
                    weakSelf.feedTbl.reloadData()
                    ProgressHUD.dismiss()
                }
            }else{
                //                JTValidationToast.show(message: response.rawValue)
            }
        }
    }
}
extension FeedViewController:FilterValue{
    func getFiltervalue(Userinfo: [filterValuesStruct]) {
        for i in Userinfo{
            print(i)
            switch i.DateType{
            case "Users":
                feedDate.user = i.id!
            default:
                print("Nothing")
            }
        }
        fetchFeed()
    }
}

extension FeedViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objFeed.activity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FeedTableViewCell
        let ind = objFeed.activity[indexPath.row]
        cell.nameLbl.text = ind.createdPerson
        cell.contentLbl.text = ind.activityContent
        cell.datetimeLbl.text = ind.timeLine
        cell.typeLbl.text = cell.type(ind.type)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension FeedViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderColCellID, for: indexPath) as! HeaderCollectionViewCell
        cell.titleLbl.text = feedArr[indexPath.item].name
        cell.titleLbl.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = headerCol.frame.width/3.5
        let cellheight = headerCol.frame.height
        return CGSize(width: cellwidth, height: cellheight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        feedDate.contetntType = feedArr[indexPath.item].id
        fetchFeed()
    }
}
