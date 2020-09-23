//
//  UsersEntity.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 21.09.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

struct UsersEntity: Codable {
    let id: Int64
    
    let loginStatus: Bool
    let firstName: String
    let lastName: String
}
