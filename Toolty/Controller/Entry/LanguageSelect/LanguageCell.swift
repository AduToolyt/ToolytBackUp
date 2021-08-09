//
//  LanguageCell.swift
//  Toolty
//
//  Created by Hitesh Khunt on 01/07/21.
//

import UIKit

class LanguageCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        lanData.languageType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lanData.language.langSelect = lanData.laguageArray[row];
        if lanData.laguageArray[row] != "" {
            _userDefault.set(ToolytSelectedLang, forKey: ToolytSelectedLang)
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.textColor = UIColor.white
        pickerLabel.text = lanData.languageType[row].langId;
        return pickerLabel
    }
    
    @IBOutlet weak var languagePicker: UIPickerView!
    var lanData = LanguageData()
    weak var parent: LanguageSelectVC!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        languagePicker.delegate = self
        languagePicker.dataSource = self
    }
    
}

