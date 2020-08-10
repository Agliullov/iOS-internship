//
//  FiltersEntity.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 01.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

struct FiltersEntity: Codable {
    let id: Int64
    
    let text: String
    var isOn: Bool
}
