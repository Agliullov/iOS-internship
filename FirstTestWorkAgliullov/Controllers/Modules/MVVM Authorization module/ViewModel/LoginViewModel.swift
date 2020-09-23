//
//  LoginViewModel.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftUtilities

struct LoginViewModel: AuthorizationLoginViewModelProtocol {
    
    let activityIndicator = ActivityIndicator()
    
    let credentialsValid: Driver<Bool>
    
    init(usernameText: Driver<String>, passwordText: Driver<String>) {
        
        let usernameValid = usernameText
            .distinctUntilChanged()
            .throttle(RxTimeInterval.milliseconds(Int(0.3)))
            .map { $0.utf8.count > 3 }
        
        let passwordValid = passwordText
            .distinctUntilChanged()
            .throttle(RxTimeInterval.milliseconds(Int(0.3)))
            .map { $0.utf8.count > 7 }
        
        credentialsValid = Driver.combineLatest(usernameValid, passwordValid) { $0 && $1 }
    }
    
    func login(_ username: String, password: String) -> Observable<AuthenticationStatus> {
        return AuthorizationManager.sharedManager.login(username, password: password)
    }
}
