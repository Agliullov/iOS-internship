//
//  ProfHelpViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class ProfHelpViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Проф. помощь"
    self.tabBarItem.image = UIImage(named: "tools")
    UITabBar.appearance().tintColor = GREEN_COLOR
    
    self.view.backgroundColor = UIColor.yellow
  }
}

