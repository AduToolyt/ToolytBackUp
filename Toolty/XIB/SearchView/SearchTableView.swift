//
//  SearchTableView.swift
//  EasyMed_Client
//
//  Created by Chirag Patel on 07/07/20.
//  Copyright © 2020 Chirag Patel. All rights reserved.
//

import UIKit

class SearchTableView: ConstrainedHeaderTableView, UITextFieldDelegate {
    
    weak var parent: UIViewController?
    
    @IBOutlet weak var tfInput: JPTextField!
    
    @IBAction func tfEditingChange(_ textField: UITextField) {
        let str = textField.text!.trimmedString()
        if let parentVC = parent as? OrderVC {
            parentVC.searchText = str
            if arrResult.isEmpty {
                if str.isEmpty {
                    parentVC.loadMore = LoadMore()
                    parentVC.getAPIData()
                } else if str.count > 3 {
                    parentVC.loadMore = LoadMore()
                    parentVC.getFilterData(arrResult)
                }
            } else {
                parentVC.loadMore = LoadMore()
                parentVC.getFilterData(arrResult)
            }
        } else if let parentVC = parent as? SelectOptionVC {
            parentVC.getFilteredData(on: str)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfInput.resignFirstResponder()
        return true
    }
}
