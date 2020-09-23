//
//  AuthenticationStatus.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

enum AuthenticationStatus {
    case none
    case error(AuthenticationError)
    case user(String)
}
