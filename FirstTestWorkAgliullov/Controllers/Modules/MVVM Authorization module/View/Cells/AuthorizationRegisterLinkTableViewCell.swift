//
//  AuthorizationRegisterLinkTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 21.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class AuthorizationRegisterLinkTableViewCell: DefaultGridViewBlockCell {
    
    private let leftText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Забыли пароль?"
        label.font = UIFont.systemFont(ofSize: 15.0)
        let attributedString = NSMutableAttributedString(string: label.text ?? "", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, /*.link: URL(string: "https://www.google.com") as Any,*/ .foregroundColor : UIColor.greenColor])
        label.attributedText = attributedString
        return label
    }()
    
    private let rightText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "Регистрация"
        label.font = UIFont.systemFont(ofSize: 15.0)
        let attributedString = NSMutableAttributedString(string: label.text ?? "", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, /*.link: URL(string: "https://www.google.ru") as Any,*/ .foregroundColor : UIColor.greenColor])
        label.attributedText = attributedString
        return label
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubview(leftText)
        contentView.addSubview(rightText)
        
        let constraint: [NSLayoutConstraint] = [
            leftText.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            leftText.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: leftText.bottomAnchor),
            
            rightText.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: rightText.bottomAnchor),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: rightText.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
}
