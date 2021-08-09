//
//  LanguageData.swift
//  Toolty
//
//  Created by Hitesh Khunt on 01/07/21.
//

import UIKit

class LanguageData: NSObject {

    var language: Language!
    var languageCells: [LangauageCell] = []
    var languageType: [LangauageType] = []
    var laguageArray : [String] = []
    override init() {
        super.init()
        language = Language()
        languageCells = [ .pickerCell ]
        languageType = [ .english, .african, .german, .french, .vietnames, .thai, .malay, .indonesia, .japanese ]
        laguageArray = ["en","af","de","fr","vi","th","ms","id","ja"]
    }
   
    enum LangauageType {
        case english
        case african
        case german
        case french
        case vietnames
        case thai
        case malay
        case indonesia
        case japanese
                        
        var langId: String {
            switch self {
            case .english:
                return "English"
            case .african:
                return "African"
            case .german:
                return "German"
            case .french:
                return "French"
            case .vietnames:
                return "Vietnamese"
            case .thai:
                return "Thai"
            case .malay:
                return "Malay"
            case .indonesia:
                return "Indonesia"
            case .japanese:
                return "Japanese"
            }
        }
    }
    
    enum LangauageCell {
        case pickerCell
        
        var cellId: String {
            switch self {
            case .pickerCell:
                return "languagePickerCell"
            }
        }
        
        var cellHeight: CGFloat {
            switch self {
            default:
                return 250.widthRatio
            }
        }
    }
}

extension LanguageData {
    func getAppVersion(completion : @escaping(ResponseType,NSDictionary) -> ()){
        KPWebCall.call.getAppVersion(param: language.paramVersionDict()) {(json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                completion(.success, dict)
            }else{
               // JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error, json as! NSDictionary)
            }
        }
    }
    func getUpdateLanguage(completion : @escaping(ResponseType,NSDictionary) -> ()){
        KPWebCall.call.updateAppLanguage(param: language.paramLangaugeDict()) {(json, statusCode) in
            guard let dict = json as? NSDictionary else {return}
            if statusCode == 200{
                completion(.success, dict)
            }else{
               // JTValidationToast.show(message: dict.getStringValue(key: "response"),type: .error)
                completion(.error, json as! NSDictionary)
            }
        }
    }
}

