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
    self.title = "Помощь вещами"
    self.tabBarItem.image = UIImage(named: "shirt")
    UITabBar.appearance().tintColor = GREEN_COLOR
    
    self.view.backgroundColor = UIColor.gray
  }
}

