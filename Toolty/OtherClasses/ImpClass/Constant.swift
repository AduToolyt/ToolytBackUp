//
//  Constant.swift
//  Gradex
//
//  Created by Multipz Technology on 11/06/21.
//

import UIKit
import Foundation

/*---------------------------------------------------
Screen Size
---------------------------------------------------*/
let _screenSize     = UIScreen.main.bounds.size
let _screenFrame    = UIScreen.main.bounds

/*---------------------------------------------------
 Constants
 ---------------------------------------------------*/
let _defaultCenter  = NotificationCenter.default
let _userDefault    = UserDefaults.standard
let _application    = UIApplication.shared
let _appDelegator   = _application.delegate! as! AppDelegate
let _bundleID = Bundle.main.bundleIdentifier

let fileManager = FileManager.default
let mainUrl: URL? = Bundle.main.url(forResource: "Menu", withExtension: "json")
var subUrl: URL?

/*---------------------------------------------------
Paging Structure
---------------------------------------------------*/
struct LoadMore{
    var index : Int = 0
    var isLoading: Bool = false
    var limit: Int = 20
    var isLoaded = false
    
    var offset: Int{
        return index * limit
    }
}

/*---------------------------------------------------
 Custom print
 ---------------------------------------------------*/
func kprint(items: Any...) {
    #if DEBUG
        for item in items {
            print(item)
        }
    #endif
}

/*---------------------------------------------------
 User Default and Notification keys
 ---------------------------------------------------*/
let GardexAuthTokenKey          = "GardexAuthTokenKey"
let GardexOnBoardingKey         = "GardexOnBoardingKey"
let ToolytSelectedLang         = "ToolytSelectedLang"
let ToolytSkipOnboarding         = "ToolytSkipOnboarding"
let ToolytSkipLoginConfirm      = "ToolytSkipLoginConfirm"

let _googleApiKey = "AIzaSyB_ngnymqS413eI14doTVtN9SK86trtQ5c"



/*---------------------------------------------------
 Current loggedIn User
 ---------------------------------------------------*/
//"#FFF6A42B",#FFFF7F5E
var arrLang: [Language]!
var arrColors: [String] = ["#FF74BD91", "#FF6394BA", "#FFA55FB1", "#FFAF9854", "#7bbcd7", "#49dc61", "#1598D5", "#FF8F5D", "#574D4D", "#ff0000", "#45ad58", "#ffc20f", "#166ccc", "#DA70D6", "#5855d6", "#7bbcd7", "#49dc61", "#1598D5", "#FF8F5D", "#574D4D", "#ff0000", "#45ad58", "#ffc20f", "#166ccc", "#DA70D6", "#5855d6", "#7bbcd7", "#49dc61", "#1598D5", "#FF8F5D", "#574D4D", "#ff0000", "#45ad58", "#ffc20f", "#166ccc", "#DA70D6", "#5855d6", "#7bbcd7", "#49dc61", "#1598D5", "#FF8F5D", "#574D4D", "#ff0000", "#45ad58", "#ffc20f", "#166ccc", "#DA70D6", "#5855d6", "#7bbcd7", "#49dc61", "#1598D5", "#FF8F5D", "#574D4D", "#ff0000", "#45ad58", "#ffc20f", "#166ccc", "#DA70D6", "#5855d6", "#7bbcd7", "#49dc61", "#1598D5", "#FF8F5D", "#574D4D", "#ff0000", "#45ad58", "#ffc20f", "#166ccc", "#DA70D6", "#5855d6", "#7bbcd7", "#49dc61", "#1598D5", "#FF8F5D", "#574D4D"]


let _deviceId = UIDevice.current.identifierForVendor!.uuidString
let _deviceName = UIDevice.current.systemName
let _deviceInternalMemory = Double(Double((ProcessInfo.processInfo.physicalMemory)) / (1024.0 * 1024.0 * 1024.0))
let _deviceInternetSpeed = ""
let _deviceBattery = UIDevice.current.batteryState
let _deviceVersion = UIDevice.current.systemVersion
let _deviceModel = UIDevice.current.modelName
let _deviceMemoryAvailable = UIDevice.current.systemFreeSize
var _filterUser: FilterUserName!
var _userList: UserList!
var _VisitStatusFilter: VisitStatusFilter!
var _user: User!
var _labels : LabelData!
var _privilege : Privilege!
var _mapOption : MapsOption!
var _addMenu : MapsOption!
var _oppOption : OpporunityOption!
var _LeadViewleadStatus :LeadViewleadStatus!
var _LeadViewleadSource:LeadViewleadSource!
var _LeadViewindustries:LeadViewindustries!
var _LeadViewUserList:LeadViewUserList!
var arrManageLabel : [LabelData] = []
var _custLead: CustLeadLists!
/*---------------------------------------------------
 Device Extention
 ---------------------------------------------------*/
extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else {
            return false
        }
    }
}

//MARK:- Constant
//-------------------------------------------------------------------------------------------
// Common
//-------------------------------------------------------------------------------------------

var _statusBarHeight: CGFloat = {
    if #available(iOS 11.0, *) {
        if UIDevice.current.hasNotch {
            return _appDelegator.window!.safeAreaInsets.top
        } else {
            return 20
        }
    } else {
        return 20
    }
}()


var _bottomBarHeight: CGFloat = {
    if #available(iOS 11.0, *) {
        if UIDevice.current.hasNotch {
            return _appDelegator.window!.safeAreaInsets.bottom
        } else {
            return 0
        }
    } else {
        return 0
    }
}()

let _navigationHeight          : CGFloat = _statusBarHeight + 44
let _vcTransitionTime                    = 0.3
let _imageFadeTransitionTime   : Double  = 0.3

/*---------------------------------------------------
 Date Formatter and number formatter
 ---------------------------------------------------*/
let _serverFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = TimeZone(abbreviation: "UTC")
    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    df.locale = Locale(identifier: "en_US_POSIX")
    return df
}()

let _deviceFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = TimeZone.current
    df.dateFormat = "yyyy-MM-dd"
    return df
}()

let _timeFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    return dateFormatter
}()

var timeZoneOffset : String{
    let timeZone = TimeZone.current.secondsFromGMT()
    return "\(timeZone)"
}

func convertFormat(time: String) -> String{
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "HH:mm:ss"
    let showDate = inputFormatter.date(from: time)
    inputFormatter.dateFormat = "hh:mm a"
    let resultString = inputFormatter.string(from: showDate!)
    return resultString
}

func convertTimeFormat(time: String) -> String{
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    let showDate = inputFormatter.date(from: time)
    inputFormatter.dateFormat = "a"
    let resultString = inputFormatter.string(from: showDate!)
    return resultString
}

let _numberFormatter:NumberFormatter = {
    let format = NumberFormatter()
    format.locale = Locale(identifier: "en_US")
    format.numberStyle = .decimal
    format.allowsFloats = true
    format.minimumFractionDigits = 3
    format.maximumFractionDigits = 3
    return format
}()

func getCurrentTimeZone() -> String {
        let localTimeZoneAbbreviation: Int = TimeZone.current.secondsFromGMT()
        let items = (localTimeZoneAbbreviation / 3600)
        return "\(items)"
}

let _btmNavigationHeight       : CGFloat = _bottomAreaSpacing + 64
let _btmNavigationHeightSearch : CGFloat = _bottomAreaSpacing + 64 + 45
let _bottomAreaSpacing         : CGFloat = _appDelegator.window!.rootViewController!.bottomLayoutGuide.length
let _tabBarHeight              : CGFloat = (60.widthRatio) + _bottomAreaSpacing


let googleKey = "AIzaSyB_ngnymqS413eI14doTVtN9SK86trtQ5c"

/// If google key is empty than location fetch via goecode.
var isGooleKeyFound : Bool = {
    return !googleKey.isEmpty
}()


class DiskStatus {

    //MARK: Formatter MB only
    class func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }


    //MARK: Get String Value
    class var totalDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
        }
    }

    class var freeDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
        }
    }

    class var usedDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
        }
    }


    //MARK: Get raw value
    class var totalDiskSpaceInBytes:Int64 {
        get {
            do {
                let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value
                return space!
            } catch {
                return 0
            }
        }
    }

    class var freeDiskSpaceInBytes:Int64 {
        get {
            do {
                let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
                return freeSpace!
            } catch {
                return 0
            }
        }
    }

    class var usedDiskSpaceInBytes:Int64 {
        get {
            let usedSpace = totalDiskSpaceInBytes - freeDiskSpaceInBytes
            return usedSpace
        }
    }

}


/*-----------------------------------------------------------------------------------------------------------------
            Icons Name Constants
 ------------------------------------------------------------------------------------------------------------*/

let logoutIcon = "logout.png"
let helpIcon = "help.png"
let feedbackIcon = "feedback.png"
let languageIcon = "language.png"

let favouriteIcon = "ic_favourite.png"
