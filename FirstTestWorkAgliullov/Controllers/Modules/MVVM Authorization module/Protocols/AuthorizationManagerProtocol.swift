//
//  AuthorizationManagerProtocol.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import RxSwift
import RxRelay

protocol AuthorizationManagerProtocol {
    var status: BehaviorRelay<AuthenticationStatus> { get }
    var sections: [UsersEntity] { get }
    
    func login(_ username: String, password: String) -> Observable<AuthenticationStatus>
    func logout()
}
