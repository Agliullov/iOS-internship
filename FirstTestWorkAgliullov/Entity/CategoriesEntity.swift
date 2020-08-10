//
//  CategoriesEntity.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 27.07.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation
import Firebase

struct CategoriesEntity: Codable {
    let id: Int64
    let primaryKey: String
    
    let title: String
    let imageName: String
    
    init(id: Int64, primaryKey: String, title: String, imageName: String) {
        self.id = id
        self.imageName = imageName
        self.primaryKey = primaryKey
        self.title = title
    }
}
