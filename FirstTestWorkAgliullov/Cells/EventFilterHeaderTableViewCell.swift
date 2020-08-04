//
//  DefaultTableViewHeaderFooterView.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DefaultTableViewHeaderFooterView: UITableViewHeaderFooterView {
  
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.textAlignment = .left
    label.numberOfLines = 1
    return label
  }()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setup()

  }
  
  private func setup() {
    self.contentView.addSubview(self.titleLabel)
    
    NSLayoutConstraint.activate([
      //self.titleLabel.heightAnchor.constraint(equalToConstant: 20.0),
      self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
      self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
      self.contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor),
      self.contentView.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20)
    ])
    
  }
}
