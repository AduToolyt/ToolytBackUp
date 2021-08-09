//
//  JTabBarController.swift
//  Gradex
//
//  Created by Multipz Technology on 12/06/21.
//

import UIKit

class JTabBarController: UITabBarController {
    var tabBarView : CustomTabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
}

extension JTabBarController {
    
    func prepareUI() {
        tabBar.isHidden = true
        addCustomTabBar()
    }
    
    func addCustomTabBar() {
        tabBarView = CustomTabBarView.getView()
        self.selectedIndex = 0
        tabBarView.getSelectedIndex { idx in
            self.selectedIndex = idx
        }
        view.addSubview(tabBarView)
    }
    
}
