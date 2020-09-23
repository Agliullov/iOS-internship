//
//  AuthorizationViewControllerViewModelProtocol.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import RxSwift
import RxCocoa

protocol AuthorizationLoginViewModelProtocol {
    
    var credentialsValid: Driver<Bool> { get }
    
    func login(_ username: String, password: String) -> Observable<AuthenticationStatus>
}

