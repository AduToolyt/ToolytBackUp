//
//  HomeTblCell.swift
//  Toolty
//
//  Created by Devang Lakhani  on 7/8/21.
//

import UIKit

class HomeTblCell: UITableViewCell {
    @IBOutlet weak var topCollView: UICollectionView!
    @IBOutlet weak var lblSectionTitle : UILabel!
    @IBOutlet weak var lblSchedualTime : UILabel!
    @IBOutlet weak var lblCompanyName : UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblSchedualMin : UILabel!
    @IBOutlet weak var lblLeadStatus: UILabel!
    @IBOutlet weak var lblVisitStatus : UILabel!
    @IBOutlet weak var btnSection: UIButton!
    @IBOutlet weak var noDataView : UIView!
    @IBOutlet weak var lblNoData : UILabel!
    @IBOutlet weak var dataView : UIView!
    @IBOutlet weak var lblContent : UILabel!
    
    var cellType : EnumHome = .collCell
    weak var parentCell : HomeVC!
    
    
    func prepareSchedualCell(){
        
        for schedualData in parentCell.objData.arrUpcoming{
            dataView.isHidden = false
            noDataView.isHidden = true
            let time = convertFormat(time: schedualData.schedualTime)
            let filterTime = time.filter{$0 != ":"}
            let hours = filterTime.prefix(2)
            let min = filterTime.suffix(5)
            lblSchedualTime.text = "\(hours)"
            lblSchedualMin.text = "\(min)"
            lblCompanyName.text = schedualData.copanyName
            lblFullName.text = schedualData.fullName
            lblLeadStatus.text = schedualData.leadStatus
            lblVisitStatus.text = "+" + "\(parentCell.objData.schedualCount)" + "VISITS"
            lblContent.text = schedualData.visitContent
        }
    }
    
}

//MARK:- CollectionView Delegate & DataSource Methods
extension HomeTblCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return parentCell == nil ? 0 : 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType{
        case .collCell:
            return parentCell.objData == nil ? 0 : parentCell.objData.arrPending.isEmpty ? 1 : parentCell.objData.arrPending.count
        case .missedActivityCell:
            return parentCell.objData == nil ? 0 : parentCell.objData.arrMissedActivity.isEmpty ? 1 : parentCell.objData.arrMissedActivity.count
        default : return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellType == .collCell && parentCell.objData != nil && parentCell.objData.arrPending.isEmpty || cellType == .missedActivityCell && parentCell.objData != nil && parentCell.objData.arrMissedActivity.isEmpty{
            let cell : EmptyCollCell
            cell = topCollView.dequeueReusableCell(withReuseIdentifier: "noDataCell", for: indexPath) as! EmptyCollCell
            cell.setText(str: "No Completed Orders Available")
            return cell
        }
        let cell : ManageCollCell
        cell = topCollView.dequeueReusableCell(withReuseIdentifier: cellType.collCellId, for: indexPath) as! ManageCollCell
        
        if cellType == .collCell && parentCell.objData != nil{
            cell.preparePendingCell(data: parentCell.objData.arrPending[indexPath.row], type: cellType,getIndexPathColor: indexPath.row)
        }
        
        if cellType == .missedActivityCell && parentCell.objData != nil{
            cell.prepareMissingActivityCell(data: parentCell.objData.arrMissedActivity[indexPath.row], type: cellType)
        }
        return cell
    }
}

//MARK:- CollectionView Delegate Flow Layout Methods
extension HomeTblCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType{
        case .collCell:
            let height = 90.widthRatio
            let width = height * 0.78
            return CGSize(width: width, height: height)
        case .missedActivityCell:
            let height = 110.widthRatio
            let width  = height *  0.72
            return CGSize(width: width, height: height)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch cellType{
        case .collCell,.missedActivityCell:
            return 15
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellType{
        case .collCell,.missedActivityCell:
            return UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 10)
        default : return UIEdgeInsets()
        }
    }
    
}

