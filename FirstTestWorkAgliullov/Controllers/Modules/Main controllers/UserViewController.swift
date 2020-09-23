//
//  UserViewController.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 13.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.backgroundColor = UIColor.white
        
        let button = UIButton()
        
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = self.view.center
        button.setTitle("Go to auth", for: .normal)
        button.backgroundColor = UIColor.greenColor
        
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(openDetails), for: .touchUpInside)
    }
    
    @objc func openDetails() {
        guard let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthorizationVC") as? MainViewController else { return }
        loginVC.title = "Авторизация"
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
