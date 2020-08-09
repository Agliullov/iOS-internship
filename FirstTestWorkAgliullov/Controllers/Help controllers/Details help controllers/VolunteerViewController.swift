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
        title = "Стать волонтером"
        tabBarItem.image = UIImage(named: "hands")
        UITabBar.appearance().tintColor = UIColor.greenColor
        
        view.backgroundColor = UIColor.red
    }
}

