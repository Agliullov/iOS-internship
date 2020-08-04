//
//  DefaultGalleryImageCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 02.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DefaultGalleryImageCell: DefaultGridViewBlockCell {
  
  var imageNames: [String] = []
  
  override func initialSetup() {
    super.initialSetup()
    
  }
  
  func setup(imageNames: [String]) {
    
    let mainImageView = UIImageView()
    mainImageView.translatesAutoresizingMaskIntoConstraints = false
    
    let secondImageView = UIImageView()
    secondImageView.translatesAutoresizingMaskIntoConstraints = false
    
    let thirdImageView = UIImageView()
    thirdImageView.translatesAutoresizingMaskIntoConstraints = false
    
    if let mainImage = UIImage(named: imageNames[0]) {
      mainImageView.image = mainImage
    }
    if let secondImage = UIImage(named: imageNames[1]) {
      secondImageView.image = secondImage
    }
    if let thirdImage = UIImage(named: imageNames[2]) {
      thirdImageView.image = thirdImage
    }
    
    self.contentView.addSubview(mainImageView)
    self.contentView.addSubview(secondImageView)
    self.contentView.addSubview(thirdImageView)
    
    let constraints: [NSLayoutConstraint] = [
      self.contentView.heightAnchor.constraint(equalTo: mainImageView.heightAnchor, constant: 15.0),
      
      mainImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height * 0.3),
      mainImageView.widthAnchor.constraint(equalToConstant: self.contentView.frame.width * 0.7),
      mainImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
      mainImageView.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
      
      secondImageView.topAnchor.constraint(equalTo: mainImageView.topAnchor),
      secondImageView.heightAnchor.constraint(equalToConstant: self.contentView.frame.width * 0.25),
      secondImageView.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10.0),
      self.contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: secondImageView.rightAnchor),
      
      thirdImageView.topAnchor.constraint(equalTo: secondImageView.bottomAnchor, constant: 10.0),
      thirdImageView.heightAnchor.constraint(equalToConstant: self.contentView.frame.width * 0.25),
      thirdImageView.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 10.0),
      self.contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: thirdImageView.rightAnchor),
      mainImageView.bottomAnchor.constraint(equalTo: thirdImageView.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
    self.setNeedsLayout()
  }
}
