//
//  StaffHelpViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class StaffHelpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Помощь вещами"
        tabBarItem.image = UIImage(named: "shirt")
        UITabBar.appearance().tintColor = UIColor.greenColor
        
        view.backgroundColor = UIColor.gray
    }
}

