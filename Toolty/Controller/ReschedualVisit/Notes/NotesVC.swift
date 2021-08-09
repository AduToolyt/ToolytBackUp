//
//  NotesVC.swift
//  Toolty
//
//  Created by Chirag Patel on 28/07/21.
//

import UIKit

class NotesVC: ParentViewController {
    @IBOutlet weak var txtView : UITextView!
    var content = ""
    var completion : ((String) -> ()) = {_ in}

    override func viewDidLoad() {
        super.viewDidLoad()
        txtView.text = content
    }
}

//MARK:- TextView Delegate Methods
extension NotesVC : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        content = textView.text
    }
    
    @IBAction func btnOkTapped(_ sender: UIButton){
        completion(content)
        self.navigationController?.popViewController(animated: true)
    }
}
