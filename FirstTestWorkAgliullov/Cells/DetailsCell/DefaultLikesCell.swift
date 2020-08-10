//
//  DefaultLikesCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 02.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DefaultLikesCell: DefaultGridViewBlockCell {
    
    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.likesGrayColor
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    override func initialSetup() {
        super.initialSetup()
        contentView.backgroundColor = UIColor.likesGrayImage
        contentView.addSubview(likesCountLabel)
    }
    
    func setup(imageNames: [String], likesCount: String) {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = -10
        stackView.distribution = .equalCentering
        
        for (index, imageName) in imageNames.enumerated() {
            if index != imageNames.count {
                let image = UIImage(named: imageName)
                let faceImageView = UIImageView()
                faceImageView.translatesAutoresizingMaskIntoConstraints = false
                faceImageView.image = image
                
                stackView.addArrangedSubview(faceImageView)
            }
        }
        
        likesCountLabel.text = likesCount
        contentView.addSubview(stackView)
        
        let constraints: [NSLayoutConstraint] = [
            stackView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.5),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10.0),
            
            likesCountLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            likesCountLabel.leftAnchor.constraint(equalTo: stackView.rightAnchor, constant: 10.0)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
