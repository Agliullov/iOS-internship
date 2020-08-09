//
//  DetailsInfoDefaultCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 02.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DetailsInfoDefaultCell: DefaultGridViewBlockCell {
    
    private let defaultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.imageColor
        return imageView
    }()
    
    private let defaultTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubview(defaultImageView)
        contentView.addSubview(defaultTitleLabel)
        
        let constraints: [NSLayoutConstraint] = [
            //defaultImageView
            defaultImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            defaultImageView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            defaultImageView.widthAnchor.constraint(equalToConstant: 15.0),
            defaultImageView.heightAnchor.constraint(equalToConstant: 15.0),
            
            //defaultTitleLabel
            defaultTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            defaultTitleLabel.leftAnchor.constraint(equalTo: defaultImageView.rightAnchor, constant: 10.0),
            contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: defaultTitleLabel.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: defaultTitleLabel.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setup(imageName: String, titles: [String], textColor: UIColor, font: UIFont?, attributedText: NSMutableAttributedString?) {
        if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) {
            defaultImageView.image = image
        }
        
        var titlesJoinded: String = ""
        for title in titles {
            titlesJoinded += "\(title) \n"
        }
        
        defaultTitleLabel.text = titlesJoinded
        
        guard let font = font else { return }
        defaultTitleLabel.font = font
        
        guard let attrText = attributedText else { return }
        defaultTitleLabel.attributedText = attrText
    }
}
