//
//  AuthorizationButtonTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 21.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class AuthorizationButtonTableViewCell: DefaultGridViewBlockCell {
    
    var loginButtonHandler: (() -> Void)?
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7.0
        button.clipsToBounds = true
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = UIColor.greenColor
        return button
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        loginButton.addTarget(self, action: #selector(logIn(sender:)), for: .touchUpInside)
        contentView.addSubview(loginButton)
        
        let constraint: [NSLayoutConstraint] = [
            loginButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            loginButton.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: loginButton.rightAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
    
    @objc private func logIn(sender: UIButton) {
        self.loginButtonHandler?()
        print("press")
    }
    
}
