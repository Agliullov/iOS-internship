//
//  EventFilterTableViewCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 30.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class EventFilterTableViewCell: UITableViewCell { //Ячейка фильтра
  
  var complitionHandler: (() -> ())?
  
  var filterLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 17.0)
    return label
  }()
  
  var filterSwitch: UISwitch = {
    let filterSwitch = UISwitch()
    filterSwitch.translatesAutoresizingMaskIntoConstraints = false
    filterSwitch.onTintColor = GREEN_COLOR
    return filterSwitch
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initSetup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.initSetup()
  }
  
  fileprivate func initSetup(){
    self.addSubview(filterLabel)
    self.addSubview(filterSwitch)
    
    self.filterSwitch.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
    
    let constraints: [NSLayoutConstraint] = [
      //filterLabel
      self.filterLabel.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
      self.filterLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
      self.contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: self.filterLabel.bottomAnchor),
      
      //filterSwitch
      self.contentView.layoutMarginsGuide.rightAnchor.constraint(equalTo: self.filterSwitch.rightAnchor),
      self.filterSwitch.centerYAnchor.constraint(equalTo: self.filterLabel.centerYAnchor),
      self.filterSwitch.leftAnchor.constraint(equalTo: self.filterLabel.rightAnchor, constant: 8.0)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
  
  func setup(filter: FilterViewControllerDataSourse) {
    self.filterLabel.text = filter.text
    self.filterSwitch.isOn = filter.isOn
  }
  
  @objc func switchValueChange() {
    self.complitionHandler?()
  }
}
