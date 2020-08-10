//
//  DefaultSingleInfoCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 03.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DefaultSingleInfoCell: DefaultGridViewBlockCell {
    
    private let defaultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubview(defaultLabel)
        
        let constraints: [NSLayoutConstraint] = [
            defaultLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            defaultLabel.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: defaultLabel.bottomAnchor),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: defaultLabel.rightAnchor),
            defaultLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.7)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setup(title: String, textColor: UIColor, font: UIFont, attributedText: NSMutableAttributedString?) {
        defaultLabel.text = title
        defaultLabel.textColor = textColor
        defaultLabel.font = font
        
        guard let attrText = attributedText else { return }
        defaultLabel.attributedText = attrText
    }
}
