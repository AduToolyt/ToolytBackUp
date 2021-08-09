//
//  KPWebCall.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import Foundation
import MapKit
let _storageUrl = "https://services.toolyt.com/"

// MARK: Web Operation
class AccessTokenAdapter: RequestAdapter {
    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}

enum HostMode {
    case production
    case local
    
    var baseUrl: String {
        switch self {
        case .production:
            return ""
        case .local:
            return "https://services.toolyt.com/"
        }
    }
}

enum ResponseType: String {
    case error = "error"
    case success = "success"
    case none = "none"
    
    init(str: String) {
        self = ResponseType(rawValue: str) ?? .none
    }
}


// Hosting mode
let _hostMode = HostMode.local

typealias WSBlock = (_ json: Any?, _ flag: Int) -> ()

class KPWebCall: NSObject {
    
    static var call: KPWebCall = KPWebCall()
    let geoLocation = CLGeocoder()

    typealias WSProgress = (Progress) -> ()?
    
    let manager: SessionManager
    var networkManager: NetworkReachabilityManager = NetworkReachabilityManager()!
    var headers: HTTPHeaders {
        return ["Accept": "application/json"]
    }
    var paramEncode: ParameterEncoding = JSONEncoding.default
    let timeOutInteraval: TimeInterval = 60
    var successBlock: (String, HTTPURLResponse?, AnyObject?, WSBlock) -> Void
    var errorBlock: (String, HTTPURLResponse?, NSError, WSBlock) -> Void
    
    override init() {
        manager = Alamofire.SessionManager.default
        
        // Will be called on success of web service calls.
        successBlock = { (relativePath, res, respObj, block) -> Void in
            // Check for response it should be there as it had come in success block
            if let response = res{
                kprint(items: "Response Code: \(response.statusCode)")
                kprint(items: "Response(\(relativePath)): \(String(describing: respObj))")
                
                if response.statusCode == 200 {
                    block(respObj, response.statusCode)
                } else {
                    if response.statusCode == 401 {
                        if _user != nil{
                            _appDelegator.removeUserAndNavToLogin()
                            if let msg = respObj?["message"] as? String{
                                kprint(items: msg)
                            }else{
                                kprint(items: kTokenExpire)
                            }
                        }
                        block(respObj, response.statusCode)
                    }else {
                        block(respObj, response.statusCode)
                    }
                }
            } else {
                // There might me no case this can get execute
                block(nil, 404)
            }
        }
        
        // Will be called on Error during web service call
        errorBlock = { (relativePath, res, error, block) -> Void in
            // First check for the response if found check code and make decision
            if let response = res {
                kprint(items: "Response Code: \(response.statusCode)")
                kprint(items: "Error Code: \(error.code)")
                if let data = error.userInfo["com.alamofire.serialization.response.error.data"] as? NSData {
                    let errorDict = (try? JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary
                    if errorDict != nil {
                        kprint(items: "Error(\(relativePath)): \(errorDict!)")
                        block(errorDict!, response.statusCode)
                    } else {
                        let code = response.statusCode
                        block(nil, code)
                    }
                } else if response.statusCode == 401 {
                    block([_appName: kInternetDown] as AnyObject, response.statusCode)
                    _appDelegator.removeUserAndNavToLogin()
                }else {
                    block(nil, response.statusCode)
                }
                // If response not found rely on error code to find the issue
            } else if error.code == -1009 {
                kprint(items: "Error(\(relativePath)): \(error)")
                block([_appName: kInternetDown] as AnyObject, error.code)
                return
            } else if error.code == -1003  {
                kprint(items: "Error(\(relativePath)): \(error)")
                block([_appName: kHostDown] as AnyObject, error.code)
                return
            } else if error.code == -1001  {
                kprint(items: "Error(\(relativePath)): \(error)")
                block([_appName: kTimeOut] as AnyObject, error.code)
                return
            } else if error.code == 1004  {
                kprint(items: "Error(\(relativePath)): \(error)")
                block([_appName: kInternetDown] as AnyObject, error.code)
                return
            } else {
                kprint(items: "Error(\(relativePath)): \(error)")
                block(nil, error.code)
            }
        }
        super.init()
        addInterNetListner()
    }
}

// MARK: Other methods
extension KPWebCall{
    func getFullUrl(relPath : String) throws -> URL{
        do{
            if relPath.lowercased().contains("http") || relPath.lowercased().contains("www"){
                return try relPath.asURL()
            } else{
                return try (_hostMode.baseUrl+relPath).asURL()
            }
        }catch let err{
            throw err
        }
    }
    
    func setAccesTokenToHeader(token:String){
        manager.adapter = AccessTokenAdapter(accessToken: token)
    }
    
    func removeAccessTokenFromHeader(){
        manager.adapter = nil
    }
}

// MARK: - Internet Availability
extension KPWebCall{
    func addInterNetListner(){
        networkManager.startListening()
        networkManager.listener = { (status) -> Void in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
                print("No InterNet")
            }else{
                print("Internet Avail")
            }
        }
    }
    
    func isInternetAvailable() -> Bool {
        if networkManager.isReachable{
            return true
        }else{
            return false
        }
    }
}

// MARK: - Request, ImageUpload and Dowanload methods
extension KPWebCall{
    
    
    func uploadImage(relPath: String,img: UIImage?, param: [String: Any]?, withName : String = "image" ,comress: CGFloat,headerParam: HTTPHeaders?, block: @escaping WSBlock, progress: WSProgress?){
        do{
            kprint(items: "Url: \(try getFullUrl(relPath: relPath))")
            kprint(items: "Param: \(String(describing: param))")
            manager.upload(multipartFormData: { (formData) in
                if let image = img {
                    formData.append(image.pngData()!, withName: withName, fileName: "image.png" , mimeType: "image/png")
                }
                if let _ = param{
                    for (key, value) in param!{
                        formData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)!, withName: key)
                    }
                }
            }, to: try getFullUrl(relPath: relPath), method: HTTPMethod.post, headers: (headerParam ?? headers), encodingCompletion: { encoding in
                switch encoding{
                case .success(let req, _, _):
                    req.uploadProgress(closure: { (prog) in
                        progress?(prog)
                    }).responseJSON { (resObj) in
                        switch resObj.result{
                        case .success:
                            if let resData = resObj.data{
                                do {
                                    let res = try JSONSerialization.jsonObject(with: resData, options: []) as AnyObject
                                    self.successBlock(relPath, resObj.response, res, block)
                                } catch let errParse{
                                    kprint( items: errParse)
                                    self.errorBlock(relPath, resObj.response, errParse as NSError, block)
                                }
                            }
                            break
                        case .failure(let err):
                            kprint( items: err)
                            self.errorBlock(relPath, resObj.response, err as NSError, block)
                            break
                        }
                    }
                    break
                case .failure(let err):
                    kprint( items: err)
                    self.errorBlock(relPath, nil, err as NSError, block)
                    break
                }
            })
        }catch let err{
            self.errorBlock(relPath, nil, err as NSError, block)
        }
    }

    
    @discardableResult func postRequest(relPath: String, param: [String: Any]?, headerParam: HTTPHeaders?, timeout: TimeInterval? = nil, block: @escaping WSBlock)-> DataRequest?{
        do{
            kprint(items: "Url: \(try getFullUrl(relPath: relPath))")
            kprint(items: "Param: \(String(describing: param))")
            
            var req = try URLRequest(url: getFullUrl(relPath: relPath), method: HTTPMethod.post, headers: (headerParam ?? headers))
            req.timeoutInterval = timeout ?? timeOutInteraval
            let encodedURLRequest = try paramEncode.encode(req, with: param)
            return Alamofire.request(encodedURLRequest).responseJSON { (resObj) in
                switch resObj.result{
                case .success:
                    if let resData = resObj.data{
                        do {
                            let res = try JSONSerialization.jsonObject(with: resData, options: []) as AnyObject
                            print("**************RESPONSE DATA**************")
                            print(res)
                            self.successBlock(relPath, resObj.response, res, block)
                        } catch let errParse{
                            kprint(items: errParse)
                            self.errorBlock(relPath, resObj.response, errParse as NSError, block)
                        }
                    }
                    break
                case .failure(let err):
                    kprint(items: err)
                    self.errorBlock(relPath, resObj.response, err as NSError, block)
                    break
                }
            }
        }catch let error{
            kprint(items: error)
            errorBlock(relPath, nil, error as NSError, block)
            return nil
        }
    }
}

//MARK:- Entry
extension KPWebCall {
    
    func getAppVersion(param :[String : Any], block : @escaping WSBlock){
        kprint(items: "---------- App Version ------------")
        let relPath = "app/get_app_version"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func loginVerifyUser(param: [String: Any], block: @escaping WSBlock) {
        kprint(items: "------------ Verify User Login ----------")
        let relPath = "app/verify-user"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func loginVerifyFetchLocation(param: [String: Any], block: @escaping WSBlock) {
        kprint(items: "------------ Verify User Location ----------")
        let relPath = "app/fetch-verify-login-location"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }

    func forgotPassword(param: [String: Any], block: @escaping WSBlock) {
        kprint(items: "------------ Forgot Password ----------")
        let relPath = "app/forget-password-with-username"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }

    func attendanceSelfie(param:[String : Any],image : UIImage?, block : @escaping WSBlock){
        kprint(items: "----------- Attendance Selfie ------")
        let relPath = "app/update-attendance-selfie"
        uploadImage(relPath: relPath, img: image, param: param, comress: 0.8, headerParam: nil, block: block, progress: nil)
    }
    
    func updateAppLanguage(param: [String: Any], block: @escaping WSBlock) {
        kprint(items: "------------ Upadate Langauge ----------")
        let relPath = "app/update-user-app-language"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func homeOverviewData(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- Home Data -----------")
        let relPath = "app/overview-details"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func homeInsightData(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- insight Data -----------")
        let relPath = "app/insight"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    func homeLeaderboardData(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- insight Data -----------")
        let relPath = "app/get-leader-board-list"
        
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    func homeGoalData(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- goals overview Data -----------")
        let relPath = "app/goals_overview"
        
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    func homeMoreGoalData(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- getallsub goals Data -----------")
        let relPath = "app/get_all_sub_goals"
        
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    func homeRevenuData(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- Revenu Data -----------")
        let relPath = "app/revenueGraph"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func homeopportunityData(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- opportunityGraph Data -----------")
        let relPath = "app/opportunityGraph"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func ViewOverviewData(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- visit Data -----------")
        let relPath = "app/visit-list"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func mapoption(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- map Data -----------")
        let relPath = "app/getMapContentNew"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getallcustomers(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- Customers Data -----------")
        let relPath = "app/get_all_customers"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getUserFilterData(param: [String: Any], block : @escaping WSBlock){
        kprint(items: "----------- User Filter Data -----------")
        let relPath = "app/get_user_filter_data"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getNotificationsData(param: [String: Any], block: @escaping WSBlock){
        kprint(items: "------------ Notifications List --------------")
        let relPath = "app/get-notifications"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getUnreadCount(param: [String: Any], block: @escaping WSBlock){
        let relPath = "app/get-unread-notification-count"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func notificationMarkRead(param: [String : Any], block : @escaping WSBlock){
        let relPath = "app/notification-mark-as-read"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func readAllNotification(param: [String : Any], block : @escaping WSBlock){
        let relPath = "app/mark-all-notifications-as-read"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getAddMenuData(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "------------ Add Menu Data -------------")
        let relPath  = "app/get-menus"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getVisitData(param: [String : Any], block : @escaping WSBlock){
        kprint(items: "------------ Visit Data -------------")
        let relPath = "app/lead-customer-visit-details"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getAssignData(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "----------- Assign Data -------------")
        let relPath = "app/view-schedule-visit-form"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getAllTimeSlots(param: [String : Any], block : @escaping WSBlock){
        kprint(items: "------------ Time Slots -----------")
        let relPath = "app/fetch-visit-schedule-time-slots"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
        
    }
    
    func getContactList(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "------------ Contact List  -------------")
        let relPath  = "app/get-all-contacts-in-one-go-new"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    //app/get_global_region_filter_data
    
    func getGlobalregion(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "------------Global region  -------------")
        let relPath  = "app/get_global_region_filter_data"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    //app/get_zones_filter_data
    func getTeamsFilter(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "------------app/get_team_filter_data-------------")
        let relPath  = "app/get_team_filter_data"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    

    
    //    app/get_regions_filter_data
    func getZoneFilter(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "------------app/get_zones_filter_data-------------")
        let relPath  = "app/get_zones_filter_data"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getRegionFilter(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "------------app/get_regions_filter_data-------------")
        let relPath  = "app/get_regions_filter_data"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }

    //app/get_user_filter_data
    func getUserFilter(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "------------app/get_user_filter_data-------------")
        let relPath  = "app/get_user_filter_data"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
//    app/get_all_opportunities_new
    func getDealsList(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "------------ app/get_all_opportunities_new-------------")
        let relPath  = "app/get_all_opportunities_new"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }


    func getAlongWithData(param: [String : Any], block : @escaping WSBlock){
        kprint(items: "------------- Along With -------")
        let relPath = "app/view-schedule-visit-custom-field-form"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func getCancelVisit(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "------------ Cancel Visit ----------")
        let relPath = "app/cancel-user-visit"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, timeout: nil, block: block)
    }
    
    func submitReschedualVisit(param : [String : Any], block : @escaping WSBlock){
        kprint(items: "-------------- Submit Reschedual Activity ---------")
        let relPath = "app/submit-schedule-visit-form-details"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func resetPassword(param : [String: Any], block : @escaping WSBlock){
        kprint(items: "----------------- New Password ----------")
        let relPath = "app/set-new-password"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func MenuLeadList(param : [String: Any], block : @escaping WSBlock){
        kprint(items: "----------------- Lead List Menu Section ----------")
        let relPath = "app/get_leads_list_new"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    
    func MenucustomersList(param : [String: Any], block : @escaping WSBlock){
        kprint(items: "----------------- Customers List Menu Section ----------")
        let relPath = "app/get_customers_list_new"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    
    func MenuExpensesList(param : [String: Any], block : @escaping WSBlock){
        kprint(items: "----------------- Customers List Menu Section ----------")
        let relPath = "app/get_company_expenses"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    func MenuLeaveList(param : [String: Any], block : @escaping WSBlock){
        kprint(items: "----------------- Customers List Menu Section ----------")
        let relPath = "app/view-leave-module"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    func MenuLeaveReq(param : [String: Any], block : @escaping WSBlock){
        kprint(items: "----------------- Customers List Menu Section ----------")
        let relPath = "app/leave-requests-notification"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
    func MenuFeedReq(param : [String: Any], block : @escaping WSBlock){
        kprint(items: "----------------- Customers List Menu Section ----------")
        let relPath = "app/get_user_activity"
        _ = postRequest(relPath: relPath, param: param, headerParam: nil, block: block)
    }
}

