//
//  AuthorizationSocialTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class AuthorizationSocialTableViewCell: DefaultGridViewBlockCell {
    
    var vkButtonHandler: (() -> Void)?
    var fbButtonHandler: (() -> Void)?
    var okButtonHandler: (() -> Void)?
    
    private let vkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "vkontakte"), for: .normal)
        return button
    }()
    
    private let fbButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "facebook"), for: .normal)
        return button
    }()
    
    private let okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "odnoklassniki"), for: .normal)
        return button
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        vkButton.addTarget(self, action: #selector(vkButtonDidTap), for: .touchUpInside)
        fbButton.addTarget(self, action: #selector(fbButtonDidTap), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(okButtonDidTap), for: .touchUpInside)
        
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(vkButton)
        stackView.addArrangedSubview(fbButton)
        stackView.addArrangedSubview(okButton)
        
        stackView.spacing = 40.0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        contentView.addSubview(stackView)
        
        let constraint: [NSLayoutConstraint] = [
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
    
    @objc private func vkButtonDidTap() {
        self.vkButtonHandler?()
        print("vkPress")
    }
    
    @objc private func fbButtonDidTap() {
        self.fbButtonHandler?()
        print("fbPress")
    }
    
    @objc private func okButtonDidTap() {
        self.okButtonHandler?()
        print("okPress")
    }
    
}
