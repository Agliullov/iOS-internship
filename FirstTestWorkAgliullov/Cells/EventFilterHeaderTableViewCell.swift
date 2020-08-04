//
//  EventFilterHeaderTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class EventFilterHeaderTableViewCell: UITableViewHeaderFooterView { //Заголовок фильтра
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.textAlignment = .left
    return label
  }()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.initSetup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.initSetup()
  }
  
  private func initSetup() {
    self.contentView.addSubview(self.titleLabel)
    
    let constraints: [NSLayoutConstraint] = [
      self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
      self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
      self.contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor),
      self.contentView.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}
