//
//  OnBoardingVC.swift
//  Gradex
//
//  Created by Multipz Technology on 11/06/21.
//

import UIKit
import CoreLocation
    
class OnBoardingVC: ParentViewController {
        
    var hasAllowPermission : Bool = false
    var isDrag : Bool = false
    var locationPermission = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpPageControl()
        getUserCurrLocation(isBool: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if locationPermission == false {
            locationPermission = UserLocation.sharedInstance.checkAuthorizationStatus()
        }
        if locationPermission && pageControl.currentPage == 0 {
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0),at: .right,animated: true)
            }
        }
        _defaultCenter.addObserver(self, selector: #selector(willEnterForeGround), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
            
    @objc func willEnterForeGround(){
        if locationPermission && pageControl.currentPage == 0
        {
            collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
        }
    }
}

extension OnBoardingVC{
    @IBAction func btnAllowPermissionTapped(_ sender : UIButton){
        sender.tag == 0 ? self.getUserCurrLocation(isBool: false) : self.askNotificationPrmission()
    }
}

extension OnBoardingVC {
    func askNotificationPrmission() {
        self.registerPushNotification()
        _userDefault.set(true, forKey: ToolytSkipOnboarding)
        _appDelegator.setOnBoardingStatus(value: true)
        _appDelegator.navigateUserToHome()
    }
}

extension OnBoardingVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnBoardCollCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoardCell", for: indexPath) as! OnBoardCollCell
        cell.parent = self
        cell.prepareOnboardCell(indexPath: indexPath.row)
        cell.btnPermission.tag = indexPath.row
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            if scrollView.currentPage == 0 {
                let locationPermission = UserLocation.sharedInstance.checkAuthorizationStatus()
                scrollView.isScrollEnabled = locationPermission ? true : false
            } else {
                scrollView.isScrollEnabled = false
                pageControl.currentPage = scrollView.currentPage
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if collectionView == scrollView{
            isDrag = scrollView.isDragging
            isDrag = !hasAllowPermission ? false : true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: _screenSize.width, height:  _screenSize.height)
    }
}

//MARK:- Show Alert
extension OnBoardingVC{
    func showPopup(title : String, msg : String, completion : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}
