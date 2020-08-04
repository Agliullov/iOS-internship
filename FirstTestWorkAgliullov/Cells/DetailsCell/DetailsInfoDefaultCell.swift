//
//  DetailsInfoDefaultCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 02.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DetailsInfoDefaultCell: DefaultGridViewBlockCell {
  
  var defaultImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.tintColor = IMAGE_COLOR
    return imageView
  }()
  
  var defaultTitleLabel: UILabel = {
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
    
    self.contentView.addSubview(self.defaultImageView)
    self.contentView.addSubview(self.defaultTitleLabel)
    
    let constraints: [NSLayoutConstraint] = [
      self.defaultImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.defaultImageView.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
      self.defaultImageView.widthAnchor.constraint(equalToConstant: 15.0),
      self.defaultImageView.heightAnchor.constraint(equalToConstant: 15.0),
      
      self.defaultTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.defaultTitleLabel.leftAnchor.constraint(equalTo: self.defaultImageView.rightAnchor, constant: 10.0),
      self.contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: self.defaultTitleLabel.rightAnchor),
      self.contentView.bottomAnchor.constraint(equalTo: self.defaultTitleLabel.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  func setup(imageName: String, titles: [String]) {
    if let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) {
      if #available(iOS 13.0, *) {
        self.defaultImageView.image = image
      }
      self.defaultImageView.image = image
    }
    
    var titlesJoinded: String = ""
    for title in titles {
      titlesJoinded += "\(title) \n"
    }
    
    self.defaultTitleLabel.text = titlesJoinded
  }
}
