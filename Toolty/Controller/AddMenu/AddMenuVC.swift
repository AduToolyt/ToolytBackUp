//
//  AddMenuVC.swift
//  Toolty
//
//  Created by Chirag Patel on 14/07/21.
//

import UIKit

class AddMenuVC: ParentViewController {
    
    var menuData = AddMenuData()
    var arrMenus : [AddMenu] = []
    
    var arrFilter : [AddMenu]{
        return _appDelegator.arrMenuData.filter{$0.showIn == "2"}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUi()
    }
    
}

//MARK:- Others Methods
extension AddMenuVC{
    func prepareUi(){
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: _tabBarHeight + 10, right: 0)
        getCollNoDataCell()
    }
    
}

//MARK:- CollectionView Delegate & DataSource Methods
extension AddMenuVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrFilter.isEmpty{
            return 1
        }
        return arrFilter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if arrFilter.isEmpty{
            let cell : EmptyCollCell
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! EmptyCollCell
            cell.setText(str: "No Data Avaiable")
            return cell
        }
        
        let cell : AddMenuCollCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! AddMenuCollCell
        cell.prepareMenuCell(data: arrFilter[indexPath.row])
        
        return cell
    }
}

//MARK:- CollectionView Delegate Flow Layout Methods
extension AddMenuVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if arrFilter.isEmpty{
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
       let yourWidth = collectionView.frame.size.width / 3.0
        let yourHeight = collectionView.frame.size.width / 3.6
        return CGSize(width: yourWidth, height: yourHeight) 

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 , left: 0, bottom: 0, right: 0)
    }
}
