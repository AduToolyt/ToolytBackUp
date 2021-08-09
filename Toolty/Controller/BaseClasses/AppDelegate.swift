//
//  AppDelegate.swift
//  Gradex
//
//  Created by Multipz Technology on 11/06/21.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var moreMenuData : [AddMenu] = []
    var arrMenuData : [AddMenu] = []
    var arrAccountMenuData : [AddMenu] = []
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIWindow.appearance().overrideUserInterfaceStyle = .light
        UIDevice.current.isBatteryMonitoringEnabled = true
        GMSServices.provideAPIKey(_googleApiKey)
        GMSPlacesClient.provideAPIKey(_googleApiKey)
        
        if _userDefault.object(forKey: ToolytSelectedLang) == nil {
            _userDefault.set("en", forKey: ToolytSelectedLang)
        }
        
        if checkForUser() {
            // KPWebCall.call.setAccesTokenToHeader(token: getAuthorizationToken()!)
            self.navigateUserToHome()
        }
        
        // Check for internet
        if !KPWebCall.call.isInternetAvailable(){
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                KPWebCall.call.networkManager.listener?(NetworkReachabilityManager.NetworkReachabilityStatus.notReachable)
            })
        }
        
        if isOnBoardingOver(){
            navigateUserToHome()
        }
        return true
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Toolty")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    var managedObjectContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteUserObject() {
        _user = nil
        let users = User.fetchDataFromEntity(predicate: nil, sortDescs: nil)
        for user in users{
            managedObjectContext.delete(user)
        }
        saveContext()
    }
    
    func removeUserAndNavToLogin() {
        removeAuthorizationToken()
        KPWebCall.call.removeAccessTokenFromHeader()
        deleteUserObject()
        if let nav = window?.rootViewController as? UINavigationController{
            _ = nav.popToRootViewController(animated: true)
        }
    }
}

extension AppDelegate {
    
    // Check user is already logged in or not.
    func checkForUser() -> Bool {
        let users = User.fetchDataFromEntity(predicate: nil, sortDescs: nil)
        if !users.isEmpty && getAuthorizationToken() != nil {
            _user = users.first!
            return true
        } else {
            return false
        }
    }
    
    func navigateUserToHome() {
        let nav = window?.rootViewController as! KPNavigationViewController
        
        let onBoarding = UIStoryboard.init(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "OnBoardingVC")
        
        let entVC = UIStoryboard.init(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
        
        let confirmVC = UIStoryboard.init(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "LoginConfirm")
        
        //let homeCont = UIStoryboard.init(name: "Entry", bundle: nil).instantiateViewController(withIdentifier: "JTabBarController")
        
        if checkForUser(){
            KPWebCall.call.setAccesTokenToHeader(token: _appDelegator.getAuthorizationToken()!)
            nav.viewControllers = [onBoarding,entVC,confirmVC]
        } else {
            if _userDefault.bool(forKey: ToolytSkipOnboarding) == false {
                nav.viewControllers = [onBoarding]
            } else {
                nav.viewControllers = [entVC]
            }
        }
        _appDelegator.window?.rootViewController = nav
    }
    
    func removeUserInfoAndNavToLogin() {
        removeAuthorizationToken()
        //removeFCMToken()
        //removeWelcomeToken()
        KPWebCall.call.removeAccessTokenFromHeader()
        //SocketManager.shared.disConnect()
        //unregisterForNormalNotifications()
        //removeAllNotification()
        deleteUserObject()
        if let nav = window?.rootViewController as? UINavigationController{
            _ = nav.popToRootViewController(animated: true)
        }
    }
}

extension AppDelegate {
    
    func storeAuthorizationToken(strToken: String) {
        _userDefault.set(strToken, forKey: GardexAuthTokenKey)
        _userDefault.synchronize()
    }
    
    func getAuthorizationToken() -> String? {
        return _userDefault.value(forKey: GardexAuthTokenKey) as? String
    }
    
    func removeAuthorizationToken() {
        _userDefault.removeObject(forKey: GardexAuthTokenKey)
        _userDefault.synchronize()
    }
    
    func setOnBoardingStatus(value : Bool){
        _userDefault.set(value, forKey: GardexOnBoardingKey)
        _userDefault.synchronize()
    }
    
    func isOnBoardingOver() -> Bool{
        return _userDefault.value(forKey: GardexOnBoardingKey) as? Bool ?? false
    }
    
    func setOverLoginStatus(value: Bool){
        _userDefault.set(value, forKey: ToolytSkipLoginConfirm)
        _userDefault.synchronize()
    }
    
    func isAttendanceOverStatus() -> Bool{
        return _userDefault.value(forKey: ToolytSkipLoginConfirm) as? Bool ?? false
    }
}

extension AppDelegate {
    func getDataFromJsonString() {
        do {
            let documentDirectory = try Toolty.fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            subUrl = documentDirectory.appendingPathComponent("Menu.json")
            loadFile(mainPath: mainUrl!, subPath: subUrl!)
        } catch {
            print(error)
        }
    }
    
    func loadFile(mainPath: URL, subPath: URL){
        if Toolty.fileManager.fileExists(atPath: subPath.path){
        }else{
            decodeData(pathName: mainPath)
            decodeDataAccount(pathName: mainPath)
        }
        
    }
    
    
    func decodeData(pathName: URL){
        do{
            let jsonData = try Data(contentsOf: pathName)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let object = json as? [Any] {
                for dictData in object {
                    let objMenu = AddMenu(dict: dictData as! NSDictionary)
                    arrMenuData.append(objMenu)
                }
                print(arrMenuData.count)
            } else {
                print("JSON is invalid")
            }
        } catch {}
    }
    
    func decodeDataAccount(pathName: URL){
        do{
            let jsonData = try Data(contentsOf: pathName)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let object = json as? [Any] {
                for dictData in object {
                    let objMenu = AddMenu(dict: dictData as! NSDictionary)
                    arrAccountMenuData.append(objMenu)
                }
                print(arrAccountMenuData.count)
            } else {
                print("JSON is invalid")
            }
        } catch {}
    }
}

extension AppDelegate {
    
    func getPrivilegeJsonData(isFromAccount:Bool)  {
        if _privilege.lead_add == 1 {
            _appDelegator.arrMenuData[0].showIn = "2"
            _appDelegator.arrAccountMenuData[0].showIn = "2"
            
        }
        if _privilege.customer_add == 1 {
            _appDelegator.arrMenuData[1].showIn = "2"
            _appDelegator.arrAccountMenuData[1].showIn = "2"
            
        }
        if _privilege.contacts_menu_add == 1 {
            _appDelegator.arrMenuData[2].showIn = "2"
            _appDelegator.arrAccountMenuData[2].showIn = "2"
            
        }
        if _privilege.account_add == 1 {
            _appDelegator.arrMenuData[3].showIn = "2"
            _appDelegator.arrAccountMenuData[3].showIn = "2"
            
        }
        if _privilege.oppurtunity_add == 1 {
            _appDelegator.arrMenuData[4].showIn = "2"
            _appDelegator.arrAccountMenuData[4].showIn = "2"
            
        }
        if _privilege.task_add == 1 {
            _appDelegator.arrMenuData[5].showIn = "2"
            _appDelegator.arrAccountMenuData[6].showIn = "2"
            
        }
        if _privilege.visit_view == 1{
            _appDelegator.arrMenuData[6].showIn = "2"
            _appDelegator.arrAccountMenuData[7].showIn = "2"
            
        }
        if _privilege.visit_schedule == 1{
            _appDelegator.arrMenuData[7].showIn = "2"
            _appDelegator.arrAccountMenuData[8].showIn = "2"
            
        }
        if _privilege.expense_add == 1 {
            _appDelegator.arrMenuData[8].showIn = "2"
            _appDelegator.arrAccountMenuData[5].showIn = "2"
            
        }
        if _privilege.service_job_add == 1 {
            _appDelegator.arrMenuData[9].showIn = "2"
            _appDelegator.arrAccountMenuData[9].showIn = "2"
            
        }
        if _privilege.order_view == 1{
            _appDelegator.arrMenuData[10].showIn = "2"
            _appDelegator.arrAccountMenuData[10].showIn = "2"
            
        }
        if _privilege.leave_apply == 1{
            _appDelegator.arrMenuData[11].showIn = "2"
            _appDelegator.arrAccountMenuData[11].showIn = "2"
            
        }
        if _privilege.stock_add == 1 {
            _appDelegator.arrMenuData[12].showIn = "2"
            _appDelegator.arrAccountMenuData[12].showIn = "2"
            
        }
        if _privilege.form_menu_add == 1 {
            _appDelegator.arrMenuData[13].showIn = "2"
            _appDelegator.arrAccountMenuData[13].showIn = "2"
            
        }
        
        if _privilege.distributor_add == 1 {
            _appDelegator.arrMenuData[14].showIn = "2"
            _appDelegator.arrAccountMenuData[14].showIn = "2"
            
        }
        if _privilege.start_beat == 1{
            _appDelegator.arrMenuData[15].showIn = "2"
            _appDelegator.arrAccountMenuData[15].showIn = "2"
        }
        if _privilege.broadcast_view == 1{
            _appDelegator.arrMenuData[16].showIn = "2"
            _appDelegator.arrAccountMenuData[16].showIn = "2"
            
        }
        if _privilege.approval_form_menu_add == 1 {
            _appDelegator.arrMenuData[17].showIn = "2"
            _appDelegator.arrAccountMenuData[17].showIn = "2"
            
        }
    }
}
