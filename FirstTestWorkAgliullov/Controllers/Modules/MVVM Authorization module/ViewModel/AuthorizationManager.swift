//
//  AuthorizationManager.swift
//  FirstTestWorkAgliullov
//
//  Created by Раис Аглиуллов on 20.08.2020.
//  Copyright © 2020 Ильдар Аглиуллов. All rights reserved.
//

import RxSwift
import RxRelay

class AuthorizationManager: AuthorizationManagerProtocol {
    
    let status = BehaviorRelay<AuthenticationStatus>.init(value: .none)
    
    static let sharedManager = AuthorizationManager()
    private let firebaseDataService = FirebaseDataService()
    
    var sections: [UsersEntity] = []
    
    fileprivate init() {}
    
    func login(_ username: String, password: String) -> Observable<AuthenticationStatus> {
        
        firebaseDataService.getUsersFirebaseData { (users) in
            //Нужна проверка на вводимое username и password и содержимое users
            if let usersInFB = users, usersInFB.count != 0 {
                self.sections = usersInFB
            }
        }
        
        return Observable.from(sections)
            .map { users in
                guard let root = users as? UsersEntity, let loginStatus = root.loginStatus as? Bool
                    else { return .error(.badResponse)}
                if loginStatus {
                    guard let firstName = root.firstName as? String, let _ = root.lastName as? String
                        else { return .error(.badResponse)}
                    return .user("\(firstName)")
                } else {
                    return .error(.badCredentials)
                }
        }.catchErrorJustReturn(.error(.server))
    }
    
    func logout() {
        status.accept(.none)
    }
}
