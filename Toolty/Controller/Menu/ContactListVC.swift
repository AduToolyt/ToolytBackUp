//
//  ContactListVC.swift
//  Toolty
//
//  Created by Nizamudheen on 06/08/21.
//

import UIKit
import ContactsUI

class ContactListVC: ParentUIController{

    var contactData = ContactListDataModel()
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var contactTableView : UITableView!
    @IBOutlet weak var contactAddButton : UIButton!
    @IBOutlet weak var searchButton : UIButton!
    @IBOutlet weak var lblCount : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.tableFooterView = UIView()
        lblTitle.text = "Contacts".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

}

extension ContactListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactData.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if contactData.contacts.count == 0{
            return UITableViewCell()
        }else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
            cell.prepareContactListCell(contact: contactData.contacts[indexPath.row])
            return cell
        }
        
    }
    
    
}


extension ContactListVC{
    func getData(){
        self.showActivityHud()
        contactData.getContactList { [self] ResponseType, arrayList in
            self.hideActivityHud()
            debugPrint(" Result:::sssss \(arrayList)")
            self.lblCount.text = "\(self.contactData.contactCount) Contacts"
            self.contactTableView.reloadData()
        }
    }
}
