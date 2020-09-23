//
//  AuthorizationTextFieldTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class AuthorizationTextFieldTableViewCell: DefaultGridViewBlockCell {
    
    private var needShowPass: Bool = false
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        return textField
    }()
    
    private let textFieldName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.likesGrayColor
        return label
    }()
    
    private let showPassButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "passVisible"), for: .normal)
        button.backgroundColor = .clear
        button.isHidden = true
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.likesGrayColor
        return view
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubview(textField)
        contentView.addSubview(textFieldName)
        contentView.addSubview(showPassButton)
        contentView.addSubview(separatorView)
        
        let constraints: [NSLayoutConstraint] = [
            textFieldName.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            textFieldName.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: textFieldName.rightAnchor),
            
            textField.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 6.0),
            textField.leftAnchor.constraint(equalTo: textFieldName.leftAnchor),
            
            showPassButton.leftAnchor.constraint(equalTo: textField.rightAnchor, constant: 8.0),
            showPassButton.rightAnchor.constraint(equalTo: textFieldName.rightAnchor),
            showPassButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            
            separatorView.heightAnchor.constraint(equalToConstant: 1.0),
            separatorView.topAnchor.constraint(equalTo: showPassButton.bottomAnchor, constant: 5.0),
            separatorView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: textFieldName.rightAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setup(isPassTextField: Bool) {
        if isPassTextField == true {
            textFieldName.text = "Пароль"
            
            textField.placeholder = "Введите пароль"
            textField.isSecureTextEntry = true
            textField.clearButtonMode = .whileEditing
            showPassButton.isHidden = false
            showPassButton.addTarget(self, action: #selector(showPassButtonTapped(sender:)), for: .touchUpInside)
        } else {
            textFieldName.text = "E-mail"
            
            textField.placeholder = "Введите e-mail"
            textField.clearButtonMode = .whileEditing
            showPassButton.isHidden = true
        }
    }
    
    @objc private func showPassButtonTapped(sender: UIButton) {
        self.needShowPass = !self.needShowPass
        
        if self.needShowPass == true {
            textField.isSecureTextEntry = false
        } else {
            textField.isSecureTextEntry = true
        }
    }
}
