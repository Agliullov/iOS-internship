//
//  VolunteerViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class VolunteerViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Стать волонтером"
    self.tabBarItem.image = UIImage(named: "hands")
    UITabBar.appearance().tintColor = GREEN_COLOR
    
    self.view.backgroundColor = UIColor.red
  }
}

