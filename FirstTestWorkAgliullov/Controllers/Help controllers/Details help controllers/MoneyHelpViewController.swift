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
    self.title = "Помощь деньгами"
    self.tabBarItem.image = UIImage(named: "coins")
    UITabBar.appearance().tintColor = GREEN_COLOR
    
    self.view.backgroundColor = UIColor.blue
  }
}

