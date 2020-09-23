//
//  LoginNavigationController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class LoginNavigationController: UINavigationController {
    
    var loginController: LoginViewController? {
        return _loginController()
    }
    
    fileprivate func _loginController() -> LoginViewController? {
        return viewControllers.first as? LoginViewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationBar.barTintColor = UIColor.greenColor
    }
}
