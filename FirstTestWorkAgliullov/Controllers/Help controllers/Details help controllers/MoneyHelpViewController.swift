//
//  MoneyHelpViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class MoneyHelpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Помощь деньгами"
        tabBarItem.image = UIImage(named: "coins")
        UITabBar.appearance().tintColor = UIColor.greenColor
        
        view.backgroundColor = UIColor.blue
    }
}

