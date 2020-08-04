//
//  DefaultLikesCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 02.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DefaultLikesCell: DefaultGridViewBlockCell {
  
  override func initialSetup() {
    super.initialSetup()
    
    self.contentView.backgroundColor = UIColor(red: 232 / 255, green: 237 / 255, blue: 237 / 255, alpha: 1.0)
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
    
    let likesCountLabel = UILabel()
    likesCountLabel.translatesAutoresizingMaskIntoConstraints = false
    likesCountLabel.textColor = UIColor(red: 148 / 255, green: 153 / 255, blue: 138 / 255, alpha: 1.0)
    likesCountLabel.text = likesCount
    likesCountLabel.font = UIFont.systemFont(ofSize: 13.0)
    
    self.contentView.addSubview(stackView)
    self.contentView.addSubview(likesCountLabel)
    
    let constraints: [NSLayoutConstraint] = [
      stackView.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
      stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0),
      stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.5),
      self.contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10.0),
      
      likesCountLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
      likesCountLabel.leftAnchor.constraint(equalTo: stackView.rightAnchor, constant: 10.0)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}
