//
//  DefaultGridViewBlockCell.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 02.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import UIKit

class DefaultGridViewBlockCell: UITableViewCell {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initialSetup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.initialSetup()
  }
  
  func initialSetup() {
    
  }
}
