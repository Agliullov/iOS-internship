//
//  DefaultSingleInfoCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 03.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DefaultSingleInfoCell: DefaultGridViewBlockCell {
  
  var defaultLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .left
    label.backgroundColor = .clear
    return label
  }()
  
  override func initialSetup() {
    super.initialSetup()
    
    self.contentView.addSubview(self.defaultLabel)
    
    let constraints: [NSLayoutConstraint] = [
      self.defaultLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
      self.defaultLabel.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
      self.contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: self.defaultLabel.bottomAnchor),
      self.contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: self.defaultLabel.rightAnchor),
      self.defaultLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.7)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  func setup(title: String) {
    self.defaultLabel.text = title
    self.setNeedsLayout()
  }
}
