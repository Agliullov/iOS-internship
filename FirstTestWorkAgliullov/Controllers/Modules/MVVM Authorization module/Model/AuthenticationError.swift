//
//  AuthenticationError.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import Foundation

enum AuthenticationError: Error {
    case server
    case badResponse
    case badCredentials
}
