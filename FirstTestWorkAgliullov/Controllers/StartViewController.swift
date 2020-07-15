//
//  StartViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class StartViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().tintColor = UIColor(red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor(red: 102 / 255, green: 166 / 255, blue: 54 / 255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.selectedIndex = 2
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(#function)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(#function)
    }
}
