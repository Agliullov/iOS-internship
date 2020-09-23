//
//  AuthorizationLabelTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class AuthorizationLabelTableViewCell: DefaultGridViewBlockCell {
    
    private let mainLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    var topConstraints: NSLayoutConstraint = NSLayoutConstraint()
    
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubview(mainLabel)
        
        self.topConstraints = mainLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor)
        
        let constraint:[NSLayoutConstraint] = [
            self.topConstraints,
            mainLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: mainLabel.rightAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: mainLabel.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
    
    func setupValue(textLabel: String, textAlignment: NSTextAlignment, textColor: UIColor, attributedText: NSMutableAttributedString?, padding: CGFloat?) {
        mainLabel.text = textLabel
        mainLabel.textAlignment = textAlignment
        mainLabel.textColor = textColor
        
        if let padding = padding {
            self.topConstraints.isActive = false
            let topConstraint = mainLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: padding)
            topConstraint.isActive = true
        }
        
        guard let attrText = attributedText else { return }
        mainLabel.attributedText = attrText
    }
    
}
