//
//  cahrtpagerViewController.swift
//  Toolty
//
//  Created by Suraj on 21/07/21.
//

import UIKit


class cahrtpagerViewController: UIPageViewController,UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var index = 0
    var identifiers: NSArray = ["RevenuGraphViewController","opportiunityGraphViewController"]
    override func viewDidLoad() {
        
        self.dataSource = self
        self.delegate = self
        
        let startingViewController = self.viewControllerAtIndex(index: self.index)
        let viewControllers: NSArray = [startingViewController]
        self.setViewControllers(viewControllers as! [UIViewController], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController! {
        if index == 1 {
            let vx = RevenuGraphViewController(nibName: "RevenuGraphViewController", bundle: nil)
            return vx
        }
        
        if index == 0 {
            let vx = opportiunityGraphViewController(nibName: "opportiunityGraphViewController", bundle: nil)
            return vx
        }
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.index(of: identifier)
        if index == identifiers.count - 1 {
            return nil
        }
        self.index = self.index + 1
        return self.viewControllerAtIndex(index: self.index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.index(of: identifier)
        if index == 0 {
            return nil
        }
        self.index = self.index - 1
        return self.viewControllerAtIndex(index: self.index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return self.identifiers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 0
    }
    
}

