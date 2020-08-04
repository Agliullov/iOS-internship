//
//  FilterViewControllerDataSourse.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 01.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

struct FilterViewControllerDataSourse {
  let text: String
  var isOn: Bool
  
  init(text: String, isOn: Bool) {
    self.text = text
    self.isOn = isOn
  }
  
  static func dataSourse() -> [FilterViewControllerDataSourse] {
    let dataSourse: [FilterViewControllerDataSourse] = [
      FilterViewControllerDataSourse(text: "Деньгами", isOn: false),
      FilterViewControllerDataSourse(text: "Вещами", isOn: false),
    ]
    
    return dataSourse
  }
}
